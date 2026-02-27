import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({super.key});

  @override
  State<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage>
    with TickerProviderStateMixin {

  int _selectedType = 0; // 0 = Offer, 1 = Need
  int _selectedCategory = -1;
  String? _selectedItem;
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  late AnimationController _pageAnim;
  late Animation<double> _pageFade;
  late Animation<Offset> _pageSlide;

  final List<Map<String, dynamic>> _categories = [
    {
      "label": "Produce",
      "image": "https://images.unsplash.com/photo-1601597111158-2fceff292cdc?w=400&q=80",
      "icon": Icons.grass,
    },
    {
      "label": "Equipment",
      "image": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80",
      "icon": Icons.agriculture,
    },
    {
      "label": "Labor",
      "image": "https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?w=400&q=80",
      "icon": Icons.people,
    },
    {
      "label": "Other",
      "image": "https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=400&q=80",
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
                        ),
                        const SizedBox(height: 18),
                        _buildTextField(
                          label: "Description (optional)",
                          hint: "Add any details about quality, location, etc.",
                          controller: _descController,
                          icon: Icons.notes_outlined,
                          maxLines: 3,
                        ),
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

  // ─── APP BAR ───
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

  // ─── TYPE SELECTOR ───
  Widget _buildTypeSelector() {
    final types = [
      {"label": "I Want to Offer", "image": "https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=400&q=80", "icon": "📦"},
      {"label": "I Need", "image": "https://images.unsplash.com/photo-1500595046743-cd271d694d30?w=400&q=80", "icon": "🔍"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Type", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54, letterSpacing: 0.5)),
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.transparent,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected ? Colors.green.withOpacity(0.25) : Colors.black.withOpacity(0.08),
                          blurRadius: isSelected ? 16 : 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(t["image"]!, fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade400])),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.15)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Positioned(top: 8, right: 8,
                              child: Container(
                                width: 22, height: 22,
                                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                child: const Icon(Icons.check, color: Colors.white, size: 14),
                              ),
                            ),
                          Positioned(bottom: 12, left: 12,
                            child: Row(children: [
                              Text(t["icon"]!, style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 6),
                              Text(t["label"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                            ]),
                          ),
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

  // ─── CATEGORY SELECTOR ───
  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Category", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54, letterSpacing: 0.5)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) {
            final cat = _categories[index];
            final isSelected = _selectedCategory == index;

            return _PopButton(
              onTap: () => setState(() {
                _selectedCategory = index;
                _selectedItem = null;
                _itemController.clear();
                HapticFeedback.lightImpact();
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.transparent,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected ? Colors.green.withOpacity(0.3) : Colors.black.withOpacity(0.08),
                      blurRadius: isSelected ? 14 : 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(cat["image"] as String, fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade800, Colors.green.shade500])),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.1)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(top: 8, right: 8,
                          child: Container(
                            width: 22, height: 22,
                            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                            child: const Icon(Icons.check, color: Colors.white, size: 14),
                          ),
                        ),
                      Positioned(bottom: 10, left: 12,
                        child: Text(cat["label"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
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

  // ─── ITEM SELECTOR ───
  Widget _buildItemSelector() {
    final items = _itemsByCategory[_selectedCategory] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Item", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54, letterSpacing: 0.5)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final isSelected = _selectedItem == item;
            return _PopButton(
              onTap: () {
                setState(() => _selectedItem = item);
                _itemController.text = item;
                HapticFeedback.selectionClick();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300),
                  boxShadow: isSelected ? [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))] : [],
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ─── TEXT FIELD ───
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black54, letterSpacing: 0.5)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(icon, color: Colors.green, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  // ─── SUBMIT BUTTON ───
  Widget _buildSubmitButton() {
    return _PopButton(
      onTap: () {
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text("Listing created successfully!", style: TextStyle(fontWeight: FontWeight.w600)),
            ]),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text("Post Listing", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// POP BUTTON — press scales down + bounces back
// ─────────────────────────────────────────────────────────
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
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}