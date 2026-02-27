import 'listcreated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({super.key});

  @override
  State<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage>
    with TickerProviderStateMixin {

  int _selectedType = 0;
  int _selectedCategory = -1;
  String? _selectedItem;
  int _selectedQualityTier = 0;
  double _visibilityRadius = 20;
  double _expiresInDays = 7;

  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  late AnimationController _pageAnim;
  late Animation<double> _pageFade;
  late Animation<Offset> _pageSlide;

  final Map<String, double> _mspPrices = {
    'Wheat': 22, 'Rice': 21, 'Soybean': 46, 'Cotton': 67,
    'Sugarcane': 3, 'Maize': 19, 'Onion': 15, 'Tomato': 12,
    'Potato': 10, 'Bajra': 23, 'Jowar': 30, 'Tur Dal': 70,
    'Groundnut': 55, 'Sunflower': 58,
  };

  final List<Map<String, dynamic>> _qualityTiers = [
    {"label": "Tier A - Premium", "desc": "Best quality, no defects", "value": 1.0, "color": Colors.green},
    {"label": "Tier B - Standard", "desc": "Good quality, minor imperfections", "value": 0.8, "color": Colors.orange},
    {"label": "Tier C - Basic", "desc": "Acceptable quality", "value": 0.5, "color": Colors.deepOrange},
  ];

  // UPDATED: Using local assets for Categories
  final List<Map<String, dynamic>> _categories = [
    {
      "label": "Produce",
      "image": "assets/images/produce.png",
      "icon": Icons.grass,
    },
    {
      "label": "Equipment",
      "image": "assets/images/equipment.png",
      "icon": Icons.agriculture,
    },
    {
      "label": "Labor",
      "image": "assets/images/labor.png",
      "icon": Icons.people,
    },
    {
      "label": "Other",
      "image": "assets/images/other.png",
      "icon": Icons.more_horiz,
    },
  ];

  final Map<int, List<String>> _itemsByCategory = {
    0: ["Wheat", "Rice", "Soybean", "Cotton", "Sugarcane", "Maize", "Onion", "Tomato", "Potato", "Bajra", "Jowar", "Tur Dal", "Groundnut", "Sunflower"],
    1: ["Tractor", "Harvester", "Thresher", "Sprayer", "Plough", "Rotavator", "Seed Drill", "Water Pump", "Power Tiller", "Cultivator"],
    2: ["Harvesting Labor", "Planting Labor", "Spraying Labor", "Weeding Labor", "Transport Labor", "General Farm Labor"],
    3: ["Fertilizer", "Seeds", "Pesticide", "Water", "Land", "Storage Space"],
  };

  @override
  void initState() {
    super.initState();
    _pageAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _pageFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _pageAnim, curve: Curves.easeOut));
    _pageSlide = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _pageAnim, curve: Curves.easeOut));
    _pageAnim.forward();
  }

  @override
  void dispose() {
    _pageAnim.dispose();
    _itemController.dispose();
    _qtyController.dispose();
    _descController.dispose();
    super.dispose();
  }

  double get _estimatedValue {
    final qty = double.tryParse(_qtyController.text) ?? 0;
    final msp = _mspPrices[_selectedItem] ?? 0;
    final tierMultiplier = (_qualityTiers[_selectedQualityTier]["value"] as double);
    return qty * msp * tierMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F2),
      body: SafeArea(
        child: FadeTransition(
          opacity: _pageFade,
          child: SlideTransition(
            position: _pageSlide,
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildTypeSelector(),
                        const SizedBox(height: 28),
                        _buildCategorySelector(),
                        const SizedBox(height: 28),
                        if (_selectedCategory >= 0) ...[
                          _buildItemSelector(),
                          const SizedBox(height: 22),
                        ],
                        _buildTextField(
                          label: "Item Name",
                          hint: "e.g., Wheat, Tractor, etc.",
                          controller: _itemController,
                          icon: Icons.eco_outlined,
                        ),
                        const SizedBox(height: 18),
                        _buildTextField(
                          label: "Quantity (kg)",
                          hint: "50",
                          controller: _qtyController,
                          icon: Icons.scale_outlined,
                          inputType: TextInputType.number,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 18),
                        _buildTextField(
                          label: "Description (optional)",
                          hint: "Details about quality...",
                          controller: _descController,
                          icon: Icons.notes_outlined,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 28),
                        _buildQualityTier(),
                        const SizedBox(height: 28),
                        _buildVisibilitySlider(),
                        const SizedBox(height: 22),
                        _buildExpirySlider(),
                        const SizedBox(height: 24),
                        _buildEstimatedValueCard(),
                        const SizedBox(height: 32),
                        _buildSubmitButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          _PopButton(
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back, color: Colors.black87, size: 20),
            ),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(width: 14),
          const Text("Create New Listing", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    // UPDATED: Using local assets for Type
    final types = [
      {"label": "I Want to Offer", "image": "assets/images/offer.png", "icon": "📦"},
      {"label": "I Need", "image": "assets/images/need.png", "icon": "🔍"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Type", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54)),
        const SizedBox(height: 12),
        Row(
          children: types.asMap().entries.map((entry) {
            final i = entry.key;
            final t = entry.value;
            final isSelected = _selectedType == i;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == 0 ? 8 : 0, left: i == 1 ? 8 : 0),
                child: _PopButton(
                  onTap: () => setState(() => _selectedType = i),
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: isSelected ? Colors.green : Colors.transparent, width: 2.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              t["image"]!,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(color: Colors.green.shade100),
                            ),
                          ),
                          Container(decoration: BoxDecoration(gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.55), Colors.transparent],
                            begin: Alignment.bottomCenter, end: Alignment.topCenter,
                          ))),
                          Positioned(bottom: 12, left: 12,
                            child: Row(children: [
                              Text(t["icon"]!, style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 6),
                              Text(t["label"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ]),
                          ),
                          if (isSelected)
                            const Positioned(top: 8, right: 8, child: Icon(Icons.check_circle, color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Category", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) {
            final cat = _categories[index];
            final isSelected = _selectedCategory == index;

            return _PopButton(
              onTap: () => setState(() {
                _selectedCategory = index;
                _selectedItem = null;
                _itemController.clear();
              }),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isSelected ? Colors.green : Colors.transparent, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          cat["image"],
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(color: Colors.green.shade200),
                        ),
                      ),
                      Container(decoration: BoxDecoration(gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        begin: Alignment.bottomCenter, end: Alignment.topCenter,
                      ))),
                      Positioned(bottom: 10, left: 12,
                        child: Text(cat["label"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      if (isSelected)
                        const Positioned(top: 8, right: 8, child: Icon(Icons.check_circle, color: Colors.green)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildItemSelector() {
    final items = _itemsByCategory[_selectedCategory] ?? [];
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: items.map((item) {
        final isSelected = _selectedItem == item;
        return ActionChip(
          label: Text(item),
          backgroundColor: isSelected ? Colors.green : Colors.white,
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
          onPressed: () {
            setState(() => _selectedItem = item);
            _itemController.text = item;
          },
        );
      }).toList(),
    );
  }

  Widget _buildTextField({required String label, required String hint, required TextEditingController controller, required IconData icon, TextInputType inputType = TextInputType.text, int maxLines = 1, Function(String)? onChanged}) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildQualityTier() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quality Tier", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54)),
        const SizedBox(height: 12),
        ...List.generate(_qualityTiers.length, (index) {
          final tier = _qualityTiers[index];
          final isSelected = _selectedQualityTier == index;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _PopButton(
              onTap: () => setState(() => _selectedQualityTier = index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey.shade300,
                    width: isSelected ? 2.5 : 1,
                  ),
                  color: isSelected ? Colors.green.shade50 : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tier["color"],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tier["label"],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            tier["desc"],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${((tier["value"] as double) * 100).toStringAsFixed(0)}% value",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildVisibilitySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Visibility Radius: ${_visibilityRadius.toStringAsFixed(0)} km",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            activeTrackColor: Colors.green,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Colors.green,
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(
            value: _visibilityRadius,
            min: 5,
            max: 100,
            divisions: 19,
            onChanged: (v) => setState(() => _visibilityRadius = v),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("5 km", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              Text("100 km", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpirySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expires in: ${_expiresInDays.toStringAsFixed(0)} days",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            activeTrackColor: Colors.green,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Colors.green,
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(
            value: _expiresInDays,
            min: 1,
            max: 30,
            divisions: 29,
            onChanged: (v) => setState(() => _expiresInDays = v),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("1 day", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              Text("30 days", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEstimatedValueCard() {
    final msp = _mspPrices[_selectedItem] ?? 0;
    final tierValue = ((_qualityTiers[_selectedQualityTier]["value"] as double) * 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.green.shade50,
        border: Border.all(color: Colors.green.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.green.shade700, size: 22),
              const SizedBox(width: 8),
              const Text(
                "Estimated Value",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "₹${_estimatedValue.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "कृषि Points (₹${_estimatedValue.toStringAsFixed(0)})",
            style: TextStyle(fontSize: 12, color: Colors.green.shade600, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.green.shade200,
          ),
          const SizedBox(height: 12),
          Text(
            "Based on MSP ₹${msp.toStringAsFixed(0)}/kg × $tierValue% Quality Tier ${_qualityTiers[_selectedQualityTier]["label"].toString().split(' - ')[0]}",
            style: TextStyle(fontSize: 12, color: Colors.green.shade700, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ListCreatedPage(item: "Wheat", quantity: "50", qualityTier: "A", estimatedValue: 1000, visibilityRadius: 20, expiresInDays: 7))),
          borderRadius: BorderRadius.circular(16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                "Create Listing",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Button Animation Helper
class _PopButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _PopButton({required this.child, required this.onTap});
  @override
  State<_PopButton> createState() => _PopButtonState();
}

class _PopButtonState extends State<_PopButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(_ctrl);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) { _ctrl.reverse(); widget.onTap(); },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}