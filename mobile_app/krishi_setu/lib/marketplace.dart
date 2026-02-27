/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with TickerProviderStateMixin {

  // ── SEARCH & FILTER STATE ──
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCrop = 'All';
  String _selectedLocation = 'All';
  String _selectedPriceRange = 'All';
  bool _showFilterSheet = false;

  // ── MANDI CAROUSEL ──
  int _mandiIndex = 0;
  late PageController _mandiPageController;
  Timer? _mandiTimer;

  // ── ANIMATIONS ──
  late AnimationController _headerAnim;
  late AnimationController _listAnim;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _listFade;
  late Animation<Offset> _listSlide;

  // ── DATA ──
  final List<Map<String, dynamic>> _mandiPrices = [
    {
      "crop": "Organic Wheat",
      "yourPrice": 2400,
      "marketAvg": 2500,
      "unit": "quintal",
      "icon": "🌾",
    },
    {
      "crop": "Red Tomatoes",
      "yourPrice": 45,
      "marketAvg": 40,
      "unit": "kg",
      "icon": "🍅",
    },
    {
      "crop": "Fresh Onion",
      "yourPrice": 22,
      "marketAvg": 25,
      "unit": "kg",
      "icon": "🧅",
    },
    {
      "crop": "Soybean",
      "yourPrice": 4320,
      "marketAvg": 4200,
      "unit": "quintal",
      "icon": "🌱",
    },
  ];

  final List<Map<String, dynamic>> _allListings = [
    {
      "id": 1,
      "farmerName": "Suresh Deshmukh",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Fenugreek",
      "cropType": "Produce",
      "price": 31,
      "unit": "kg",
      "rating": 4.5,
      "location": "Pune, MH",
      "qty": "80 kg",
      "image": "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Fresh",
      "badgeColor": 0xFF4CAF50,
    },
    {
      "id": 2,
      "farmerName": "Ganesh Kulkarni",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Red Tomatoes",
      "cropType": "Produce",
      "price": 45,
      "unit": "kg",
      "rating": 4.8,
      "location": "Nashik, MH",
      "qty": "120 kg",
      "image": "https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Hot Deal",
      "badgeColor": 0xFFFF5722,
    },
    {
      "id": 3,
      "farmerName": "Ramesh Patil",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Cabbage",
      "cropType": "Produce",
      "price": 18,
      "unit": "kg",
      "rating": 4.7,
      "location": "Akola, MH",
      "qty": "200 kg",
      "image": "https://images.pexels.com/photos/1245712/pexels-photo-1245712.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Bulk",
      "badgeColor": 0xFF2196F3,
    },
    {
      "id": 4,
      "farmerName": "Priya Shinde",
      "farmerEmoji": "👩‍🌾",
      "verified": false,
      "crop": "Organic Wheat",
      "cropType": "Grain",
      "price": 2400,
      "unit": "quintal",
      "rating": 4.3,
      "location": "Solapur, MH",
      "qty": "50 quintal",
      "image": "https://images.pexels.com/photos/326082/pexels-photo-326082.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Organic",
      "badgeColor": 0xFF8BC34A,
    },
    {
      "id": 5,
      "farmerName": "Vijay More",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Fresh Onion",
      "cropType": "Produce",
      "price": 22,
      "unit": "kg",
      "rating": 4.6,
      "location": "Nashik, MH",
      "qty": "500 kg",
      "image": "https://images.pexels.com/photos/4198937/pexels-photo-4198937.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "In Season",
      "badgeColor": 0xFFFF9800,
    },
    {
      "id": 6,
      "farmerName": "Anita Borse",
      "farmerEmoji": "👩‍🌾",
      "verified": true,
      "crop": "Sugarcane",
      "cropType": "Cash Crop",
      "price": 350,
      "unit": "quintal",
      "rating": 4.4,
      "location": "Kolhapur, MH",
      "qty": "10 ton",
      "image": "https://images.pexels.com/photos/1346347/pexels-photo-1346347.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Premium",
      "badgeColor": 0xFF9C27B0,
    },
  ];

  final List<String> _cropFilters = ['All', 'Produce', 'Grain', 'Cash Crop'];
  final List<String> _locationFilters = ['All', 'Pune, MH', 'Nashik, MH', 'Akola, MH', 'Solapur, MH', 'Kolhapur, MH'];
  final List<String> _priceFilters = ['All', 'Under ₹50', '₹50–₹500', 'Above ₹500'];

  List<Map<String, dynamic>> get _filteredListings {
    return _allListings.where((listing) {
      final matchSearch = _searchQuery.isEmpty ||
          listing['crop'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          listing['farmerName'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          listing['location'].toString().toLowerCase().contains(_searchQuery.toLowerCase());

      final matchCrop = _selectedCrop == 'All' || listing['cropType'] == _selectedCrop;
      final matchLocation = _selectedLocation == 'All' || listing['location'] == _selectedLocation;

      bool matchPrice = true;
      final price = listing['price'] as int;
      if (_selectedPriceRange == 'Under ₹50') matchPrice = price < 50;
      else if (_selectedPriceRange == '₹50–₹500') matchPrice = price >= 50 && price <= 500;
      else if (_selectedPriceRange == 'Above ₹500') matchPrice = price > 500;

      return matchSearch && matchCrop && matchLocation && matchPrice;
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _mandiPageController = PageController(viewportFraction: 1.0);

    _headerAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _listAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _listFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));
    _listSlide = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));

    _headerAnim.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _listAnim.forward();
    });

    // Auto-rotate mandi cards
    _mandiTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_mandiIndex + 1) % _mandiPrices.length;
      _mandiPageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mandiPageController.dispose();
    _mandiTimer?.cancel();
    _headerAnim.dispose();
    _listAnim.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters =>
      _selectedCrop != 'All' || _selectedLocation != 'All' || _selectedPriceRange != 'All';

  void _clearFilters() {
    setState(() {
      _selectedCrop = 'All';
      _selectedLocation = 'All';
      _selectedPriceRange = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    final listings = _filteredListings;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: SafeArea(
        child: Column(
          children: [

            // ── HEADER ──
            FadeTransition(
              opacity: _headerFade,
              child: SlideTransition(
                position: _headerSlide,
                child: _buildHeader(),
              ),
            ),

            // ── BODY ──
            Expanded(
              child: FadeTransition(
                opacity: _listFade,
                child: SlideTransition(
                  position: _listSlide,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [

                      // Filter chips
                      _buildFilterChips(),

                      // Active filter banner
                      if (_hasActiveFilters) _buildActiveFilterBanner(),

                      // Mandi price card
                      _buildMandiCard(),

                      const SizedBox(height: 8),

                      // Results header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "${listings.length} listings found",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            // Sort button
                            GestureDetector(
                              onTap: () => HapticFeedback.lightImpact(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.sort_rounded, size: 14, color: Colors.grey.shade600),
                                    const SizedBox(width: 4),
                                    Text("Sort", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Listings
                      if (listings.isEmpty)
                        _buildEmptyState()
                      else
                        ...listings.asMap().entries.map((e) =>
                            _ListingCard(
                              data: e.value,
                              index: e.key,
                              onBuy: () => _showActionSheet(context, e.value, 'buy'),
                              onBarter: () => _showActionSheet(context, e.value, 'barter'),
                            )
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── HEADER: back + title + search + filter ──
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          // Title row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: Colors.black87),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Marketplace",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Search bar
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search crops, farmers...",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400, size: 20),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: Icon(Icons.close_rounded, color: Colors.grey.shade400, size: 18),
                      )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Filter button
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  _showFilterBottomSheet(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: _hasActiveFilters ? Colors.green : Colors.green.shade600,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
                      if (_hasActiveFilters)
                        Positioned(
                          top: 8, right: 8,
                          child: Container(
                            width: 8, height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── HORIZONTAL FILTER CHIPS ──
  Widget _buildFilterChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12, top: 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _FilterChip(
              label: "🌾 Crop",
              value: _selectedCrop == 'All' ? null : _selectedCrop,
              onTap: () => _showCropPicker(context),
            ),
            const SizedBox(width: 8),
            _FilterChip(
              label: "📍 Location",
              value: _selectedLocation == 'All' ? null : _selectedLocation,
              onTap: () => _showLocationPicker(context),
            ),
            const SizedBox(width: 8),
            _FilterChip(
              label: "💰 Price",
              value: _selectedPriceRange == 'All' ? null : _selectedPriceRange,
              onTap: () => _showPricePicker(context),
            ),
          ],
        ),
      ),
    );
  }

  // ── ACTIVE FILTER BANNER ──
  Widget _buildActiveFilterBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_alt_rounded, color: Colors.green.shade600, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              "Filters active: ${[
                if (_selectedCrop != 'All') _selectedCrop,
                if (_selectedLocation != 'All') _selectedLocation,
                if (_selectedPriceRange != 'All') _selectedPriceRange,
              ].join(' · ')}",
              style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: _clearFilters,
            child: Text("Clear", style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ── MANDI PRICE CAROUSEL ──
  Widget _buildMandiCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          // Carousel
          SizedBox(
            height: 155,
            child: PageView.builder(
              controller: _mandiPageController,
              itemCount: _mandiPrices.length,
              onPageChanged: (i) => setState(() => _mandiIndex = i),
              itemBuilder: (context, index) {
                final m = _mandiPrices[index];
                final yourPrice = m['yourPrice'] as int;
                final marketAvg = m['marketAvg'] as int;
                final diff = yourPrice - marketAvg;
                final isFair = diff.abs() <= (marketAvg * 0.05);
                final isAbove = diff > 0;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(m['icon'] as String, style: const TextStyle(fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Today's Mandi Price (eNAM Reference)",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(m['crop'] as String, style: TextStyle(fontSize: 11, color: Colors.blue.shade700)),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Price comparison
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Your Price", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                  Text(
                                    "₹$yourPrice",
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                                  ),
                                  Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                ],
                              ),
                            ),
                            Container(width: 1, height: 44, color: Colors.grey.shade200),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Market Avg", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                    Text(
                                      "₹$marketAvg",
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                    Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Fair price strip + dots
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
            child: Column(
              children: [
                // Fair price indicator
                Builder(builder: (context) {
                  final m = _mandiPrices[_mandiIndex];
                  final yourPrice = m['yourPrice'] as int;
                  final marketAvg = m['marketAvg'] as int;
                  final diff = yourPrice - marketAvg;
                  final isFair = diff.abs() <= (marketAvg * 0.05);
                  final isAbove = diff > 0;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isFair ? Icons.check_circle_outline : (isAbove ? Icons.trending_up : Icons.trending_down),
                          color: Colors.green,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isFair ? "Fair Price" : (isAbove ? "Above Market" : "Below Market"),
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text("Compared to market average", style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                            ],
                          ),
                        ),
                        Text(
                          "${diff >= 0 ? '+' : ''}₹$diff",
                          style: TextStyle(
                            color: diff >= 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 10),

                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(_mandiPrices.length, (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _mandiIndex == i ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _mandiIndex == i ? Colors.blue : Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    )),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  "Powered by eNAM Market Insights",
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade600, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── EMPTY STATE ──
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            const Text("🔍", style: TextStyle(fontSize: 48)),
            const SizedBox(height: 14),
            const Text("No listings found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 6),
            Text("Try adjusting your filters", style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: _clearFilters,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Clear Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── BOTTOM SHEET: Filter ──
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Text("Filters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(_clearFilters);
                      setModalState(() {});
                    },
                    child: const Text("Clear All", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildFilterSection("Crop Type", _cropFilters, _selectedCrop, (val) {
                setState(() => _selectedCrop = val);
                setModalState(() {});
              }),
              const SizedBox(height: 16),
              _buildFilterSection("Location", _locationFilters, _selectedLocation, (val) {
                setState(() => _selectedLocation = val);
                setModalState(() {});
              }),
              const SizedBox(height: 16),
              _buildFilterSection("Price Range", _priceFilters, _selectedPriceRange, (val) {
                setState(() => _selectedPriceRange = val);
                setModalState(() {});
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Apply Filters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: options.map((opt) {
            final isSel = selected == opt;
            return GestureDetector(
              onTap: () { onSelect(opt); HapticFeedback.selectionClick(); },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSel ? Colors.green : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSel ? Colors.green : Colors.grey.shade300),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    color: isSel ? Colors.white : Colors.black87,
                    fontWeight: isSel ? FontWeight.w600 : FontWeight.normal,
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

  void _showCropPicker(BuildContext context) => _showPickerSheet(context, "Crop Type", _cropFilters, _selectedCrop, (v) => setState(() => _selectedCrop = v));
  void _showLocationPicker(BuildContext context) => _showPickerSheet(context, "Location", _locationFilters, _selectedLocation, (v) => setState(() => _selectedLocation = v));
  void _showPricePicker(BuildContext context) => _showPickerSheet(context, "Price Range", _priceFilters, _selectedPriceRange, (v) => setState(() => _selectedPriceRange = v));

  void _showPickerSheet(BuildContext ctx, String title, List<String> options, String current, Function(String) onSelect) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            ...options.map((opt) => ListTile(
              title: Text(opt),
              trailing: current == opt ? const Icon(Icons.check_rounded, color: Colors.green) : null,
              onTap: () {
                onSelect(opt);
                HapticFeedback.selectionClick();
                Navigator.pop(ctx);
              },
            )),
          ],
        ),
      ),
    );
  }

  // ── BUY / BARTER ACTION SHEET ──
  void _showActionSheet(BuildContext context, Map<String, dynamic> listing, String type) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),

            // Farmer + crop info
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                  child: Center(child: Text(listing['farmerEmoji'] as String, style: const TextStyle(fontSize: 26))),
                ),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(listing['farmerName'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(children: [
                    if (listing['verified'] as bool) ...[
                      const Icon(Icons.verified_rounded, color: Colors.green, size: 13),
                      const SizedBox(width: 3),
                      const Text("Verified Farmer", style: TextStyle(color: Colors.green, fontSize: 12)),
                    ] else
                      Text("Unverified", style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                  ]),
                ]),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                    const SizedBox(width: 3),
                    Text("${listing['rating']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ]),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade100),
            const SizedBox(height: 14),

            // Item details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionDetailChip("Crop", listing['crop'] as String),
                _ActionDetailChip("Price", "₹${listing['price']}/${listing['unit']}"),
                _ActionDetailChip("Qty", listing['qty'] as String),
              ],
            ),

            const SizedBox(height: 20),

            if (type == 'buy') ...[
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.shopping_cart_rounded, size: 18),
                  label: const Text("Confirm Purchase", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Request sent to ${listing['farmerName']}!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade100),
                ),
                child: Row(children: [
                  const Icon(Icons.swap_horiz_rounded, color: Colors.orange, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(child: Text("Barter lets you exchange your produce instead of paying cash.", style: TextStyle(fontSize: 13, color: Colors.black54))),
                ]),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                  label: const Text("Propose Barter", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Barter proposal sent to ${listing['farmerName']}!"),
                      backgroundColor: Colors.orange.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── FILTER CHIP WIDGET ──
class _FilterChip extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;

  const _FilterChip({required this.label, this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = value != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.green.shade300 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isActive ? value! : label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? Colors.green.shade700 : Colors.black54,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: isActive ? Colors.green.shade600 : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// ── ACTION DETAIL CHIP ──
class _ActionDetailChip extends StatelessWidget {
  final String label;
  final String value;
  const _ActionDetailChip(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }
}

// ── LISTING CARD ──
class _ListingCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final VoidCallback onBuy;
  final VoidCallback onBarter;

  const _ListingCard({
    required this.data,
    required this.index,
    required this.onBuy,
    required this.onBarter,
  });

  @override
  State<_ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<_ListingCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final badgeColor = Color(d['badgeColor'] as int);

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [

              /// IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                      /// NETWORK IMAGE
                      Image.network(
                        d['image'] as String,
                        fit: BoxFit.cover,

                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },

                        errorBuilder: (c, e, s) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade700,
                                Colors.green.shade400
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text("🌿", style: TextStyle(fontSize: 50)),
                          ),
                        ),
                      ),

                      /// RATING
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: Colors.amber, size: 14),
                              const SizedBox(width: 3),
                              Text(
                                "${d['rating']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// BADGE
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            d['badge'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      /// LOCATION
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: Colors.white, size: 12),
                              const SizedBox(width: 3),
                              Text(
                                d['location'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// CONTENT
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// FARMER
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              d['farmerEmoji'] as String,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          d['farmerName'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          d['qty'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// CROP NAME
                    Text(
                      d['crop'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// PRICE
                    Text(
                      "₹${d['price']} /${d['unit']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*//*

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with TickerProviderStateMixin {

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCrop = 'All';
  String _selectedLocation = 'All';
  String _selectedPriceRange = 'All';

  int _mandiIndex = 0;
  late PageController _mandiPageController;
  Timer? _mandiTimer;

  late AnimationController _headerAnim;
  late AnimationController _listAnim;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _listFade;
  late Animation<Offset> _listSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Organic Wheat", "yourPrice": 2400, "marketAvg": 2500, "unit": "quintal", "icon": "🌾"},
    {"crop": "Red Tomatoes",  "yourPrice": 45,   "marketAvg": 40,   "unit": "kg",      "icon": "🍅"},
    {"crop": "Fresh Onion",   "yourPrice": 22,   "marketAvg": 25,   "unit": "kg",      "icon": "🧅"},
    {"crop": "Soybean",       "yourPrice": 4320, "marketAvg": 4200, "unit": "quintal", "icon": "🌱"},
  ];

  // ── listings use local assets for the 4 images you provided ──
  final List<Map<String, dynamic>> _allListings = [
    {
      "id": 1,
      "farmerName": "Suresh Deshmukh",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Fenugreek",
      "cropType": "Produce",
      "price": 31,
      "unit": "kg",
      "rating": 4.5,
      "location": "Pune, MH",
      "qty": "80 kg",
      "assetImage": "assets/images/fenugreek.png",
      "badge": "Fresh",
      "badgeColor": 0xFF4CAF50,
    },
    {
      "id": 2,
      "farmerName": "Ganesh Kulkarni",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Red Tomatoes",
      "cropType": "Produce",
      "price": 45,
      "unit": "kg",
      "rating": 4.8,
      "location": "Nashik, MH",
      "qty": "120 kg",
      "assetImage": "assets/images/tomato.png",
      "badge": "Hot Deal",
      "badgeColor": 0xFFFF5722,
    },
    {
      "id": 3,
      "farmerName": "Ramesh Patil",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Cabbage",
      "cropType": "Produce",
      "price": 18,
      "unit": "kg",
      "rating": 4.7,
      "location": "Akola, MH",
      "qty": "200 kg",
      "assetImage": "assets/images/cabbage.png",
      "badge": "Bulk",
      "badgeColor": 0xFF2196F3,
    },
    {
      "id": 4,
      "farmerName": "Priya Shinde",
      "farmerEmoji": "👩‍🌾",
      "verified": false,
      "crop": "Organic Wheat",
      "cropType": "Grain",
      "price": 2400,
      "unit": "quintal",
      "rating": 4.9,
      "location": "Solapur, MH",
      "qty": "50 quintal",
      "assetImage": "assets/images/wheat.png",
      "badge": "Organic",
      "badgeColor": 0xFF8BC34A,
    },
    {
      "id": 5,
      "farmerName": "Vijay More",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Fresh Onion",
      "cropType": "Produce",
      "price": 22,
      "unit": "kg",
      "rating": 4.6,
      "location": "Nashik, MH",
      "qty": "500 kg",
      "assetImage": "assets/images/fenugreek.png",
      "badge": "In Season",
      "badgeColor": 0xFFFF9800,
    },
    {
      "id": 6,
      "farmerName": "Anita Borse",
      "farmerEmoji": "👩‍🌾",
      "verified": true,
      "crop": "Sugarcane",
      "cropType": "Cash Crop",
      "price": 350,
      "unit": "quintal",
      "rating": 4.4,
      "location": "Kolhapur, MH",
      "qty": "10 ton",
      "assetImage": "assets/images/wheat.png",
      "badge": "Premium",
      "badgeColor": 0xFF9C27B0,
    },
  ];

  final List<String> _cropFilters = ['All', 'Produce', 'Grain', 'Cash Crop'];
  final List<String> _locationFilters = ['All', 'Pune, MH', 'Nashik, MH', 'Akola, MH', 'Solapur, MH', 'Kolhapur, MH'];
  final List<String> _priceFilters = ['All', 'Under ₹50', '₹50–₹500', 'Above ₹500'];

  List<Map<String, dynamic>> get _filteredListings {
    return _allListings.where((l) {
      final matchSearch = _searchQuery.isEmpty ||
          l['crop'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          l['farmerName'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          l['location'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCrop = _selectedCrop == 'All' || l['cropType'] == _selectedCrop;
      final matchLoc  = _selectedLocation == 'All' || l['location'] == _selectedLocation;
      bool matchPrice = true;
      final price = l['price'] as int;
      if (_selectedPriceRange == 'Under ₹50')   matchPrice = price < 50;
      else if (_selectedPriceRange == '₹50–₹500') matchPrice = price >= 50 && price <= 500;
      else if (_selectedPriceRange == 'Above ₹500') matchPrice = price > 500;
      return matchSearch && matchCrop && matchLoc && matchPrice;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _mandiPageController = PageController();

    _headerAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _listAnim   = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _headerFade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _listFade    = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));
    _listSlide   = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));

    _headerAnim.forward();
    Future.delayed(const Duration(milliseconds: 300), () { if (mounted) _listAnim.forward(); });

    _mandiTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_mandiIndex + 1) % _mandiPrices.length;
      _mandiPageController.animateToPage(next, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });

    _searchController.addListener(() => setState(() => _searchQuery = _searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mandiPageController.dispose();
    _mandiTimer?.cancel();
    _headerAnim.dispose();
    _listAnim.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters => _selectedCrop != 'All' || _selectedLocation != 'All' || _selectedPriceRange != 'All';
  void _clearFilters() => setState(() { _selectedCrop = 'All'; _selectedLocation = 'All'; _selectedPriceRange = 'All'; });

  @override
  Widget build(BuildContext context) {
    final listings = _filteredListings;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: SafeArea(
        child: Column(
          children: [
            FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeader())),
            Expanded(
              child: FadeTransition(
                opacity: _listFade,
                child: SlideTransition(
                  position: _listSlide,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      _buildFilterChips(),
                      if (_hasActiveFilters) _buildActiveFilterBanner(),
                      _buildMandiCard(),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Text("${listings.length} listings found", style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => HapticFeedback.lightImpact(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                                child: Row(children: [
                                  Icon(Icons.sort_rounded, size: 14, color: Colors.grey.shade600),
                                  const SizedBox(width: 4),
                                  Text("Sort", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (listings.isEmpty)
                        _buildEmptyState()
                      else
                        ...listings.asMap().entries.map((e) => _ListingCard(
                          data: e.value,
                          index: e.key,
                          onBuy: () => _showActionSheet(context, e.value, 'buy'),
                          onBarter: () => _showActionSheet(context, e.value, 'barter'),
                        )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: 38, height: 38, decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_rounded, size: 20, color: Colors.black87)),
              ),
              const SizedBox(width: 12),
              const Text("Marketplace", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(14)),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search crops, farmers...",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400, size: 20),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? GestureDetector(onTap: () { _searchController.clear(); setState(() => _searchQuery = ''); }, child: Icon(Icons.close_rounded, color: Colors.grey.shade400, size: 18))
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () { HapticFeedback.lightImpact(); _showFilterBottomSheet(context); },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 46, height: 46,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
                      if (_hasActiveFilters) Positioned(top: 8, right: 8, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12, top: 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _FilterChip(label: "🌾 Crop",     value: _selectedCrop == 'All' ? null : _selectedCrop,         onTap: () => _showCropPicker(context)),
            const SizedBox(width: 8),
            _FilterChip(label: "📍 Location", value: _selectedLocation == 'All' ? null : _selectedLocation, onTap: () => _showLocationPicker(context)),
            const SizedBox(width: 8),
            _FilterChip(label: "💰 Price",    value: _selectedPriceRange == 'All' ? null : _selectedPriceRange, onTap: () => _showPricePicker(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilterBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green.shade100)),
      child: Row(
        children: [
          Icon(Icons.filter_alt_rounded, color: Colors.green.shade600, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              "Filters active: ${[if (_selectedCrop != 'All') _selectedCrop, if (_selectedLocation != 'All') _selectedLocation, if (_selectedPriceRange != 'All') _selectedPriceRange].join(' · ')}",
              style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(onTap: _clearFilters, child: Text("Clear", style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildMandiCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.blue.shade100)),
      child: Column(
        children: [
          SizedBox(
            height: 155,
            child: PageView.builder(
              controller: _mandiPageController,
              itemCount: _mandiPrices.length,
              onPageChanged: (i) => setState(() => _mandiIndex = i),
              itemBuilder: (context, index) {
                final m = _mandiPrices[index];
                final yourPrice = m['yourPrice'] as int;
                final marketAvg = m['marketAvg'] as int;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(width: 32, height: 32, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                              child: Center(child: Text(m['icon'] as String, style: const TextStyle(fontSize: 16)))),
                          const SizedBox(width: 8),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Today's Mandi Price (eNAM Reference)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87), overflow: TextOverflow.ellipsis),
                              Text(m['crop'] as String, style: TextStyle(fontSize: 11, color: Colors.blue.shade700)),
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                              Text("Your Price", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                              Text("₹$yourPrice", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                              Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                            ])),
                            Container(width: 1, height: 44, color: Colors.grey.shade200),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                Text("Market Avg", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                Text("₹$marketAvg", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                                Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                              ]),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Column(
              children: [
                Builder(builder: (context) {
                  final m = _mandiPrices[_mandiIndex];
                  final diff = (m['yourPrice'] as int) - (m['marketAvg'] as int);
                  final isFair = diff.abs() <= ((m['marketAvg'] as int) * 0.05);
                  final isAbove = diff > 0;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(isFair ? Icons.check_circle_outline : (isAbove ? Icons.trending_up : Icons.trending_down), color: Colors.green, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                          Text(isFair ? "Fair Price" : (isAbove ? "Above Market" : "Below Market"), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                          Text("Compared to market average", style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                        ])),
                        const SizedBox(width: 8),
                        Text("${diff >= 0 ? '+' : ''}₹$diff", style: TextStyle(color: diff >= 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_mandiPrices.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _mandiIndex == i ? 18 : 6, height: 6,
                    decoration: BoxDecoration(color: _mandiIndex == i ? Colors.blue : Colors.blue.shade200, borderRadius: BorderRadius.circular(3)),
                  )),
                ),
                const SizedBox(height: 6),
                Text("Powered by eNAM Market Insights", style: TextStyle(fontSize: 11, color: Colors.blue.shade600, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Text("🔍", style: TextStyle(fontSize: 48)),
          const SizedBox(height: 14),
          const Text("No listings found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 6),
          Text("Try adjusting your filters", style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: _clearFilters,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: const Text("Clear Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 18),
              Row(children: [
                const Text("Filters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(onPressed: () { setState(_clearFilters); setModalState(() {}); }, child: const Text("Clear All", style: TextStyle(color: Colors.green))),
              ]),
              const SizedBox(height: 16),
              _buildFilterSection("Crop Type", _cropFilters, _selectedCrop, (v) { setState(() => _selectedCrop = v); setModalState(() {}); }),
              const SizedBox(height: 16),
              _buildFilterSection("Location", _locationFilters, _selectedLocation, (v) { setState(() => _selectedLocation = v); setModalState(() {}); }),
              const SizedBox(height: 16),
              _buildFilterSection("Price Range", _priceFilters, _selectedPriceRange, (v) { setState(() => _selectedPriceRange = v); setModalState(() {}); }),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Apply Filters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: options.map((opt) {
            final isSel = selected == opt;
            return GestureDetector(
              onTap: () { onSelect(opt); HapticFeedback.selectionClick(); },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSel ? Colors.green : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSel ? Colors.green : Colors.grey.shade300),
                ),
                child: Text(opt, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: isSel ? FontWeight.w600 : FontWeight.normal, fontSize: 13)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showCropPicker(BuildContext ctx)     => _showPickerSheet(ctx, "Crop Type",    _cropFilters,     _selectedCrop,       (v) => setState(() => _selectedCrop = v));
  void _showLocationPicker(BuildContext ctx) => _showPickerSheet(ctx, "Location",     _locationFilters, _selectedLocation,   (v) => setState(() => _selectedLocation = v));
  void _showPricePicker(BuildContext ctx)    => _showPickerSheet(ctx, "Price Range",  _priceFilters,    _selectedPriceRange, (v) => setState(() => _selectedPriceRange = v));

  void _showPickerSheet(BuildContext ctx, String title, List<String> options, String current, Function(String) onSelect) {
    showModalBottomSheet(
      context: ctx, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            ...options.map((opt) => ListTile(
              title: Text(opt),
              trailing: current == opt ? const Icon(Icons.check_rounded, color: Colors.green) : null,
              onTap: () { onSelect(opt); HapticFeedback.selectionClick(); Navigator.pop(ctx); },
            )),
          ],
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context, Map<String, dynamic> listing, String type) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent, isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                    child: Center(child: Text(listing['farmerEmoji'] as String, style: const TextStyle(fontSize: 26)))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(listing['farmerName'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  if (listing['verified'] as bool)
                    Row(children: const [Icon(Icons.verified_rounded, color: Colors.green, size: 13), SizedBox(width: 3), Text("Verified Farmer", style: TextStyle(color: Colors.green, fontSize: 12))])
                  else
                    Text("Unverified", style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber.shade200)),
                  child: Row(children: [const Icon(Icons.star_rounded, color: Colors.amber, size: 14), const SizedBox(width: 3), Text("${listing['rating']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade100),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionDetailChip("Crop",  listing['crop'] as String),
                _ActionDetailChip("Price", "₹${listing['price']}/${listing['unit']}"),
                _ActionDetailChip("Qty",   listing['qty'] as String),
              ],
            ),
            const SizedBox(height: 20),
            if (type == 'buy') ...[
              SizedBox(width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  icon: const Icon(Icons.shopping_cart_rounded, size: 18),
                  label: const Text("Confirm Purchase", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Request sent to ${listing['farmerName']}!"),
                      backgroundColor: Colors.green, behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade100)),
                child: Row(children: [const Icon(Icons.swap_horiz_rounded, color: Colors.orange, size: 18), const SizedBox(width: 8), const Expanded(child: Text("Barter lets you exchange your produce instead of paying cash.", style: TextStyle(fontSize: 13, color: Colors.black54)))]),
              ),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade600, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                  label: const Text("Propose Barter", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Barter proposal sent to ${listing['farmerName']}!"),
                      backgroundColor: Colors.orange.shade700, behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;
  const _FilterChip({required this.label, this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = value != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? Colors.green.shade300 : Colors.grey.shade300),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(isActive ? value! : label, style: TextStyle(fontSize: 13, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal, color: isActive ? Colors.green.shade700 : Colors.black54)),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: isActive ? Colors.green.shade600 : Colors.grey),
        ]),
      ),
    );
  }
}

class _ActionDetailChip extends StatelessWidget {
  final String label;
  final String value;
  const _ActionDetailChip(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
      const SizedBox(height: 3),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
    ]);
  }
}

class _ListingCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final VoidCallback onBuy;
  final VoidCallback onBarter;
  const _ListingCard({required this.data, required this.index, required this.onBuy, required this.onBarter});

  @override
  State<_ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<_ListingCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.index * 80), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final badgeColor = Color(d['badgeColor'] as int);

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 14, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [

              // ── LOCAL ASSET IMAGE ──
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  children: [
                    Image.asset(
                      d['assetImage'] as String,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        height: 180,
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade400])),
                        child: const Center(child: Text("🌿", style: TextStyle(fontSize: 50))),
                      ),
                    ),

                    // Rating
                    Positioned(top: 12, right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)]),
                        child: Row(children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                          const SizedBox(width: 3),
                          Text("${d['rating']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ),

                    // Badge
                    Positioned(top: 12, left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(20)),
                        child: Text(d['badge'] as String, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    // Location
                    Positioned(bottom: 12, left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [
                          const Icon(Icons.location_on_rounded, color: Colors.white, size: 12),
                          const SizedBox(width: 3),
                          Text(d['location'] as String, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),

              // ── CONTENT ──
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Farmer row
                    Row(children: [
                      Container(width: 36, height: 36,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: Center(child: Text(d['farmerEmoji'] as String, style: const TextStyle(fontSize: 20)))),
                      const SizedBox(width: 8),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(d['farmerName'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        if (d['verified'] as bool)
                          Row(children: const [Icon(Icons.verified_rounded, color: Colors.green, size: 12), SizedBox(width: 3), Text("Verified Farmer", style: TextStyle(color: Colors.green, fontSize: 11))])
                        else
                          Text("Unverified", style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                      ]),
                      const Spacer(),
                      Text(d['qty'] as String, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ]),

                    const SizedBox(height: 10),

                    // Crop name
                    Text(d['crop'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),

                    const SizedBox(height: 4),

                    // Price
                    RichText(text: TextSpan(children: [
                      TextSpan(text: "₹${d['price']}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                      TextSpan(text: " /${d['unit']}",  style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                    ])),

                    const SizedBox(height: 14),

                    // ── BARTER + BUY ──
                    Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.onBarter,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(Icons.swap_horiz_rounded, color: Colors.orange.shade700, size: 18),
                              const SizedBox(width: 6),
                              Text("Barter", style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.w600, fontSize: 14)),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.onBuy,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))],
                            ),
                            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text("Buy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                            ]),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with TickerProviderStateMixin {

  // ── SEARCH & FILTER STATE ──
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCrop = 'All';
  String _selectedLocation = 'All';
  String _selectedPriceRange = 'All';
  bool _showFilterSheet = false;

  // ── MANDI CAROUSEL ──
  int _mandiIndex = 0;
  late PageController _mandiPageController;
  Timer? _mandiTimer;

  // ── ANIMATIONS ──
  late AnimationController _headerAnim;
  late AnimationController _listAnim;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _listFade;
  late Animation<Offset> _listSlide;

  // ── DATA ──
  final List<Map<String, dynamic>> _mandiPrices = [
    {
      "crop": "Organic Wheat",
      "yourPrice": 2400,
      "marketAvg": 2500,
      "unit": "quintal",
      "icon": "🌾",
    },
    {
      "crop": "Red Tomatoes",
      "yourPrice": 45,
      "marketAvg": 40,
      "unit": "kg",
      "icon": "🍅",
    },
    {
      "crop": "Fresh Onion",
      "yourPrice": 22,
      "marketAvg": 25,
      "unit": "kg",
      "icon": "🧅",
    },
    {
      "crop": "Soybean",
      "yourPrice": 4320,
      "marketAvg": 4200,
      "unit": "quintal",
      "icon": "🌱",
    },
  ];

  final List<Map<String, dynamic>> _allListings = [
    {
      "id": 1,
      "farmerName": "Suresh Deshmukh",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Fenugreek",
      "cropType": "Produce",
      "price": 31,
      "unit": "kg",
      "rating": 4.5,
      "location": "Pune, MH",
      "qty": "80 kg",
      "image": "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Fresh",
      "badgeColor": 0xFF4CAF50,
    },
    {
      "id": 2,
      "farmerName": "Ganesh Kulkarni",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Red Tomatoes",
      "cropType": "Produce",
      "price": 45,
      "unit": "kg",
      "rating": 4.8,
      "location": "Nashik, MH",
      "qty": "120 kg",
      "image": "https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Hot Deal",
      "badgeColor": 0xFFFF5722,
    },
    {
      "id": 3,
      "farmerName": "Ramesh Patil",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Cabbage",
      "cropType": "Produce",
      "price": 18,
      "unit": "kg",
      "rating": 4.7,
      "location": "Akola, MH",
      "qty": "200 kg",
      "image": "https://images.pexels.com/photos/1245712/pexels-photo-1245712.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Bulk",
      "badgeColor": 0xFF2196F3,
    },
    {
      "id": 4,
      "farmerName": "Priya Shinde",
      "farmerEmoji": "👩‍🌾",
      "verified": false,
      "crop": "Organic Wheat",
      "cropType": "Grain",
      "price": 2400,
      "unit": "quintal",
      "rating": 4.3,
      "location": "Solapur, MH",
      "qty": "50 quintal",
      "image": "https://images.pexels.com/photos/326082/pexels-photo-326082.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Organic",
      "badgeColor": 0xFF8BC34A,
    },
    {
      "id": 5,
      "farmerName": "Vijay More",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Fresh Onion",
      "cropType": "Produce",
      "price": 22,
      "unit": "kg",
      "rating": 4.6,
      "location": "Nashik, MH",
      "qty": "500 kg",
      "image": "https://images.pexels.com/photos/4198937/pexels-photo-4198937.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "In Season",
      "badgeColor": 0xFFFF9800,
    },
    {
      "id": 6,
      "farmerName": "Anita Borse",
      "farmerEmoji": "👩‍🌾",
      "verified": true,
      "crop": "Sugarcane",
      "cropType": "Cash Crop",
      "price": 350,
      "unit": "quintal",
      "rating": 4.4,
      "location": "Kolhapur, MH",
      "qty": "10 ton",
      "image": "https://images.pexels.com/photos/1346347/pexels-photo-1346347.jpeg?auto=compress&cs=tinysrgb&w=600",
      "badge": "Premium",
      "badgeColor": 0xFF9C27B0,
    },
  ];

  final List<String> _cropFilters = ['All', 'Produce', 'Grain', 'Cash Crop'];
  final List<String> _locationFilters = ['All', 'Pune, MH', 'Nashik, MH', 'Akola, MH', 'Solapur, MH', 'Kolhapur, MH'];
  final List<String> _priceFilters = ['All', 'Under ₹50', '₹50–₹500', 'Above ₹500'];

  List<Map<String, dynamic>> get _filteredListings {
    return _allListings.where((listing) {
      final matchSearch = _searchQuery.isEmpty ||
          listing['crop'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          listing['farmerName'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          listing['location'].toString().toLowerCase().contains(_searchQuery.toLowerCase());

      final matchCrop = _selectedCrop == 'All' || listing['cropType'] == _selectedCrop;
      final matchLocation = _selectedLocation == 'All' || listing['location'] == _selectedLocation;

      bool matchPrice = true;
      final price = listing['price'] as int;
      if (_selectedPriceRange == 'Under ₹50') matchPrice = price < 50;
      else if (_selectedPriceRange == '₹50–₹500') matchPrice = price >= 50 && price <= 500;
      else if (_selectedPriceRange == 'Above ₹500') matchPrice = price > 500;

      return matchSearch && matchCrop && matchLocation && matchPrice;
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _mandiPageController = PageController(viewportFraction: 1.0);

    _headerAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _listAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _listFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));
    _listSlide = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));

    _headerAnim.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _listAnim.forward();
    });

    // Auto-rotate mandi cards
    _mandiTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_mandiIndex + 1) % _mandiPrices.length;
      _mandiPageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mandiPageController.dispose();
    _mandiTimer?.cancel();
    _headerAnim.dispose();
    _listAnim.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters =>
      _selectedCrop != 'All' || _selectedLocation != 'All' || _selectedPriceRange != 'All';

  void _clearFilters() {
    setState(() {
      _selectedCrop = 'All';
      _selectedLocation = 'All';
      _selectedPriceRange = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    final listings = _filteredListings;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: SafeArea(
        child: Column(
          children: [

            // ── HEADER ──
            FadeTransition(
              opacity: _headerFade,
              child: SlideTransition(
                position: _headerSlide,
                child: _buildHeader(),
              ),
            ),

            // ── BODY ──
            Expanded(
              child: FadeTransition(
                opacity: _listFade,
                child: SlideTransition(
                  position: _listSlide,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [

                      // Filter chips
                      _buildFilterChips(),

                      // Active filter banner
                      if (_hasActiveFilters) _buildActiveFilterBanner(),

                      // Mandi price card
                      _buildMandiCard(),

                      const SizedBox(height: 8),

                      // Results header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "${listings.length} listings found",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            // Sort button
                            GestureDetector(
                              onTap: () => HapticFeedback.lightImpact(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.sort_rounded, size: 14, color: Colors.grey.shade600),
                                    const SizedBox(width: 4),
                                    Text("Sort", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Listings
                      if (listings.isEmpty)
                        _buildEmptyState()
                      else
                        ...listings.asMap().entries.map((e) =>
                            _ListingCard(
                              data: e.value,
                              index: e.key,
                              onBuy: () => _showActionSheet(context, e.value, 'buy'),
                              onBarter: () => _showActionSheet(context, e.value, 'barter'),
                            )
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── HEADER: back + title + search + filter ──
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          // Title row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: Colors.black87),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Marketplace",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Search bar
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search crops, farmers...",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400, size: 20),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: Icon(Icons.close_rounded, color: Colors.grey.shade400, size: 18),
                      )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Filter button
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  _showFilterBottomSheet(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: _hasActiveFilters ? Colors.green : Colors.green.shade600,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
                      if (_hasActiveFilters)
                        Positioned(
                          top: 8, right: 8,
                          child: Container(
                            width: 8, height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── HORIZONTAL FILTER CHIPS ──
  Widget _buildFilterChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12, top: 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _FilterChip(
              label: "🌾 Crop",
              value: _selectedCrop == 'All' ? null : _selectedCrop,
              onTap: () => _showCropPicker(context),
            ),
            const SizedBox(width: 8),
            _FilterChip(
              label: "📍 Location",
              value: _selectedLocation == 'All' ? null : _selectedLocation,
              onTap: () => _showLocationPicker(context),
            ),
            const SizedBox(width: 8),
            _FilterChip(
              label: "💰 Price",
              value: _selectedPriceRange == 'All' ? null : _selectedPriceRange,
              onTap: () => _showPricePicker(context),
            ),
          ],
        ),
      ),
    );
  }

  // ── ACTIVE FILTER BANNER ──
  Widget _buildActiveFilterBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_alt_rounded, color: Colors.green.shade600, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              "Filters active: ${[
                if (_selectedCrop != 'All') _selectedCrop,
                if (_selectedLocation != 'All') _selectedLocation,
                if (_selectedPriceRange != 'All') _selectedPriceRange,
              ].join(' · ')}",
              style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: _clearFilters,
            child: Text("Clear", style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ── MANDI PRICE CAROUSEL ──
  Widget _buildMandiCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          // Carousel
          SizedBox(
            height: 155,
            child: PageView.builder(
              controller: _mandiPageController,
              itemCount: _mandiPrices.length,
              onPageChanged: (i) => setState(() => _mandiIndex = i),
              itemBuilder: (context, index) {
                final m = _mandiPrices[index];
                final yourPrice = m['yourPrice'] as int;
                final marketAvg = m['marketAvg'] as int;
                final diff = yourPrice - marketAvg;
                final isFair = diff.abs() <= (marketAvg * 0.05);
                final isAbove = diff > 0;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(m['icon'] as String, style: const TextStyle(fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Today's Mandi Price (eNAM Reference)",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(m['crop'] as String, style: TextStyle(fontSize: 11, color: Colors.blue.shade700)),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Price comparison
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Your Price", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                  Text(
                                    "₹$yourPrice",
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                                  ),
                                  Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                ],
                              ),
                            ),
                            Container(width: 1, height: 44, color: Colors.grey.shade200),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Market Avg", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                    Text(
                                      "₹$marketAvg",
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                    Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Fair price strip + dots
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
            child: Column(
              children: [
                // Fair price indicator
                Builder(builder: (context) {
                  final m = _mandiPrices[_mandiIndex];
                  final yourPrice = m['yourPrice'] as int;
                  final marketAvg = m['marketAvg'] as int;
                  final diff = yourPrice - marketAvg;
                  final isFair = diff.abs() <= (marketAvg * 0.05);
                  final isAbove = diff > 0;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isFair ? Icons.check_circle_outline : (isAbove ? Icons.trending_up : Icons.trending_down),
                          color: Colors.green,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isFair ? "Fair Price" : (isAbove ? "Above Market" : "Below Market"),
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text("Compared to market average", style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                            ],
                          ),
                        ),
                        Text(
                          "${diff >= 0 ? '+' : ''}₹$diff",
                          style: TextStyle(
                            color: diff >= 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 10),

                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(_mandiPrices.length, (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _mandiIndex == i ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _mandiIndex == i ? Colors.blue : Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    )),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  "Powered by eNAM Market Insights",
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade600, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── EMPTY STATE ──
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            const Text("🔍", style: TextStyle(fontSize: 48)),
            const SizedBox(height: 14),
            const Text("No listings found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 6),
            Text("Try adjusting your filters", style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: _clearFilters,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Clear Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── BOTTOM SHEET: Filter ──
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Text("Filters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(_clearFilters);
                      setModalState(() {});
                    },
                    child: const Text("Clear All", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildFilterSection("Crop Type", _cropFilters, _selectedCrop, (val) {
                setState(() => _selectedCrop = val);
                setModalState(() {});
              }),
              const SizedBox(height: 16),
              _buildFilterSection("Location", _locationFilters, _selectedLocation, (val) {
                setState(() => _selectedLocation = val);
                setModalState(() {});
              }),
              const SizedBox(height: 16),
              _buildFilterSection("Price Range", _priceFilters, _selectedPriceRange, (val) {
                setState(() => _selectedPriceRange = val);
                setModalState(() {});
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Apply Filters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: options.map((opt) {
            final isSel = selected == opt;
            return GestureDetector(
              onTap: () { onSelect(opt); HapticFeedback.selectionClick(); },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSel ? Colors.green : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSel ? Colors.green : Colors.grey.shade300),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                    color: isSel ? Colors.white : Colors.black87,
                    fontWeight: isSel ? FontWeight.w600 : FontWeight.normal,
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

  void _showCropPicker(BuildContext context) => _showPickerSheet(context, "Crop Type", _cropFilters, _selectedCrop, (v) => setState(() => _selectedCrop = v));
  void _showLocationPicker(BuildContext context) => _showPickerSheet(context, "Location", _locationFilters, _selectedLocation, (v) => setState(() => _selectedLocation = v));
  void _showPricePicker(BuildContext context) => _showPickerSheet(context, "Price Range", _priceFilters, _selectedPriceRange, (v) => setState(() => _selectedPriceRange = v));

  void _showPickerSheet(BuildContext ctx, String title, List<String> options, String current, Function(String) onSelect) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            ...options.map((opt) => ListTile(
              title: Text(opt),
              trailing: current == opt ? const Icon(Icons.check_rounded, color: Colors.green) : null,
              onTap: () {
                onSelect(opt);
                HapticFeedback.selectionClick();
                Navigator.pop(ctx);
              },
            )),
          ],
        ),
      ),
    );
  }

  // ── BUY / BARTER ACTION SHEET ──
  void _showActionSheet(BuildContext context, Map<String, dynamic> listing, String type) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),

            // Farmer + crop info
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                  child: Center(child: Text(listing['farmerEmoji'] as String, style: const TextStyle(fontSize: 26))),
                ),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(listing['farmerName'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(children: [
                    if (listing['verified'] as bool) ...[
                      const Icon(Icons.verified_rounded, color: Colors.green, size: 13),
                      const SizedBox(width: 3),
                      const Text("Verified Farmer", style: TextStyle(color: Colors.green, fontSize: 12)),
                    ] else
                      Text("Unverified", style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                  ]),
                ]),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                    const SizedBox(width: 3),
                    Text("${listing['rating']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ]),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade100),
            const SizedBox(height: 14),

            // Item details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionDetailChip("Crop", listing['crop'] as String),
                _ActionDetailChip("Price", "₹${listing['price']}/${listing['unit']}"),
                _ActionDetailChip("Qty", listing['qty'] as String),
              ],
            ),

            const SizedBox(height: 20),

            if (type == 'buy') ...[
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.shopping_cart_rounded, size: 18),
                  label: const Text("Confirm Purchase", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Request sent to ${listing['farmerName']}!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade100),
                ),
                child: Row(children: [
                  const Icon(Icons.swap_horiz_rounded, color: Colors.orange, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(child: Text("Barter lets you exchange your produce instead of paying cash.", style: TextStyle(fontSize: 13, color: Colors.black54))),
                ]),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                  label: const Text("Propose Barter", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/barter');
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── FILTER CHIP WIDGET ──
class _FilterChip extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;

  const _FilterChip({required this.label, this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = value != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.green.shade300 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isActive ? value! : label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? Colors.green.shade700 : Colors.black54,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: isActive ? Colors.green.shade600 : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// ── ACTION DETAIL CHIP ──
class _ActionDetailChip extends StatelessWidget {
  final String label;
  final String value;
  const _ActionDetailChip(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }
}

// ── LISTING CARD ──
class _ListingCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final VoidCallback onBuy;
  final VoidCallback onBarter;

  const _ListingCard({
    required this.data,
    required this.index,
    required this.onBuy,
    required this.onBarter,
  });

  @override
  State<_ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<_ListingCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final badgeColor = Color(d['badgeColor'] as int);

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [

              /// IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                      /// NETWORK IMAGE
                      Image.network(
                        d['image'] as String,
                        fit: BoxFit.cover,

                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },

                        errorBuilder: (c, e, s) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade700,
                                Colors.green.shade400
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text("🌿", style: TextStyle(fontSize: 50)),
                          ),
                        ),
                      ),

                      /// RATING
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: Colors.amber, size: 14),
                              const SizedBox(width: 3),
                              Text(
                                "${d['rating']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// BADGE
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 4),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            d['badge'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      /// LOCATION
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: Colors.white, size: 12),
                              const SizedBox(width: 3),
                              Text(
                                d['location'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// CONTENT
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// FARMER
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              d['farmerEmoji'] as String,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          d['farmerName'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          d['qty'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// CROP NAME
                    Text(
                      d['crop'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// PRICE
                    Text(
                      "₹${d['price']} /${d['unit']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with TickerProviderStateMixin {

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCrop = 'All';
  String _selectedLocation = 'All';
  String _selectedPriceRange = 'All';

  int _mandiIndex = 0;
  late PageController _mandiPageController;
  Timer? _mandiTimer;

  late AnimationController _headerAnim;
  late AnimationController _listAnim;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _listFade;
  late Animation<Offset> _listSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Organic Wheat", "yourPrice": 2400, "marketAvg": 2500, "unit": "quintal", "icon": "🌾"},
    {"crop": "Red Tomatoes",  "yourPrice": 45,   "marketAvg": 40,   "unit": "kg",      "icon": "🍅"},
    {"crop": "Fresh Onion",   "yourPrice": 22,   "marketAvg": 25,   "unit": "kg",      "icon": "🧅"},
    {"crop": "Soybean",       "yourPrice": 4320, "marketAvg": 4200, "unit": "quintal", "icon": "🌱"},
  ];

  // ── listings use local assets for the 4 images you provided ──
  final List<Map<String, dynamic>> _allListings = [
    {
      "id": 1,
      "farmerName": "Suresh Deshmukh",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Fenugreek",
      "cropType": "Produce",
      "price": 31,
      "unit": "kg",
      "rating": 4.5,
      "location": "Pune, MH",
      "qty": "80 kg",
      "assetImage": "assets/images/fenugreek.png",
      "badge": "Fresh",
      "badgeColor": 0xFF4CAF50,
    },
    {
      "id": 2,
      "farmerName": "Ganesh Kulkarni",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Red Tomatoes",
      "cropType": "Produce",
      "price": 45,
      "unit": "kg",
      "rating": 4.8,
      "location": "Nashik, MH",
      "qty": "120 kg",
      "assetImage": "assets/images/tomato.png",
      "badge": "Hot Deal",
      "badgeColor": 0xFFFF5722,
    },
    {
      "id": 3,
      "farmerName": "Ramesh Patil",
      "farmerEmoji": "🧑‍🌾",
      "verified": true,
      "crop": "Fresh Cabbage",
      "cropType": "Produce",
      "price": 18,
      "unit": "kg",
      "rating": 4.7,
      "location": "Akola, MH",
      "qty": "200 kg",
      "assetImage": "assets/images/cabbage.png",
      "badge": "Bulk",
      "badgeColor": 0xFF2196F3,
    },
    {
      "id": 4,
      "farmerName": "Priya Shinde",
      "farmerEmoji": "👩‍🌾",
      "verified": false,
      "crop": "Organic Wheat",
      "cropType": "Grain",
      "price": 2400,
      "unit": "quintal",
      "rating": 4.9,
      "location": "Solapur, MH",
      "qty": "50 quintal",
      "assetImage": "assets/images/wheat.png",
      "badge": "Organic",
      "badgeColor": 0xFF8BC34A,
    },
    {
      "id": 5,
      "farmerName": "Vijay More",
      "farmerEmoji": "👨‍🌾",
      "verified": true,
      "crop": "Fresh Onion",
      "cropType": "Produce",
      "price": 22,
      "unit": "kg",
      "rating": 4.6,
      "location": "Nashik, MH",
      "qty": "500 kg",
      "assetImage": "assets/images/fenugreek.png",
      "badge": "In Season",
      "badgeColor": 0xFFFF9800,
    },
    {
      "id": 6,
      "farmerName": "Anita Borse",
      "farmerEmoji": "👩‍🌾",
      "verified": true,
      "crop": "Sugarcane",
      "cropType": "Cash Crop",
      "price": 350,
      "unit": "quintal",
      "rating": 4.4,
      "location": "Kolhapur, MH",
      "qty": "10 ton",
      "assetImage": "assets/images/wheat.png",
      "badge": "Premium",
      "badgeColor": 0xFF9C27B0,
    },
  ];

  final List<String> _cropFilters = ['All', 'Produce', 'Grain', 'Cash Crop'];
  final List<String> _locationFilters = ['All', 'Pune, MH', 'Nashik, MH', 'Akola, MH', 'Solapur, MH', 'Kolhapur, MH'];
  final List<String> _priceFilters = ['All', 'Under ₹50', '₹50–₹500', 'Above ₹500'];

  List<Map<String, dynamic>> get _filteredListings {
    return _allListings.where((l) {
      final matchSearch = _searchQuery.isEmpty ||
          l['crop'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          l['farmerName'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          l['location'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCrop = _selectedCrop == 'All' || l['cropType'] == _selectedCrop;
      final matchLoc  = _selectedLocation == 'All' || l['location'] == _selectedLocation;
      bool matchPrice = true;
      final price = l['price'] as int;
      if (_selectedPriceRange == 'Under ₹50')   matchPrice = price < 50;
      else if (_selectedPriceRange == '₹50–₹500') matchPrice = price >= 50 && price <= 500;
      else if (_selectedPriceRange == 'Above ₹500') matchPrice = price > 500;
      return matchSearch && matchCrop && matchLoc && matchPrice;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _mandiPageController = PageController();

    _headerAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _listAnim   = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _headerFade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero).animate(CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut));
    _listFade    = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));
    _listSlide   = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _listAnim, curve: Curves.easeOut));

    _headerAnim.forward();
    Future.delayed(const Duration(milliseconds: 300), () { if (mounted) _listAnim.forward(); });

    _mandiTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_mandiIndex + 1) % _mandiPrices.length;
      _mandiPageController.animateToPage(next, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });

    _searchController.addListener(() => setState(() => _searchQuery = _searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mandiPageController.dispose();
    _mandiTimer?.cancel();
    _headerAnim.dispose();
    _listAnim.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters => _selectedCrop != 'All' || _selectedLocation != 'All' || _selectedPriceRange != 'All';
  void _clearFilters() => setState(() { _selectedCrop = 'All'; _selectedLocation = 'All'; _selectedPriceRange = 'All'; });

  @override
  Widget build(BuildContext context) {
    final listings = _filteredListings;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: SafeArea(
        child: Column(
          children: [
            FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeader())),
            Expanded(
              child: FadeTransition(
                opacity: _listFade,
                child: SlideTransition(
                  position: _listSlide,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      _buildFilterChips(),
                      if (_hasActiveFilters) _buildActiveFilterBanner(),
                      _buildMandiCard(),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Text("${listings.length} listings found", style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => HapticFeedback.lightImpact(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                                child: Row(children: [
                                  Icon(Icons.sort_rounded, size: 14, color: Colors.grey.shade600),
                                  const SizedBox(width: 4),
                                  Text("Sort", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (listings.isEmpty)
                        _buildEmptyState()
                      else
                        ...listings.asMap().entries.map((e) => _ListingCard(
                          data: e.value,
                          index: e.key,
                          onBuy: () => _showActionSheet(context, e.value, 'buy'),
                          onBarter: () => _showActionSheet(context, e.value, 'barter'),
                        )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: 38, height: 38, decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_rounded, size: 20, color: Colors.black87)),
              ),
              const SizedBox(width: 12),
              const Text("Marketplace", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(14)),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search crops, farmers...",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400, size: 20),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? GestureDetector(onTap: () { _searchController.clear(); setState(() => _searchQuery = ''); }, child: Icon(Icons.close_rounded, color: Colors.grey.shade400, size: 18))
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () { HapticFeedback.lightImpact(); _showFilterBottomSheet(context); },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 46, height: 46,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
                      if (_hasActiveFilters) Positioned(top: 8, right: 8, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12, top: 2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _FilterChip(label: "🌾 Crop",     value: _selectedCrop == 'All' ? null : _selectedCrop,         onTap: () => _showCropPicker(context)),
            const SizedBox(width: 8),
            _FilterChip(label: "📍 Location", value: _selectedLocation == 'All' ? null : _selectedLocation, onTap: () => _showLocationPicker(context)),
            const SizedBox(width: 8),
            _FilterChip(label: "💰 Price",    value: _selectedPriceRange == 'All' ? null : _selectedPriceRange, onTap: () => _showPricePicker(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilterBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green.shade100)),
      child: Row(
        children: [
          Icon(Icons.filter_alt_rounded, color: Colors.green.shade600, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              "Filters active: ${[if (_selectedCrop != 'All') _selectedCrop, if (_selectedLocation != 'All') _selectedLocation, if (_selectedPriceRange != 'All') _selectedPriceRange].join(' · ')}",
              style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(onTap: _clearFilters, child: Text("Clear", style: TextStyle(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildMandiCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.blue.shade100)),
      child: Column(
        children: [
          SizedBox(
            height: 155,
            child: PageView.builder(
              controller: _mandiPageController,
              itemCount: _mandiPrices.length,
              onPageChanged: (i) => setState(() => _mandiIndex = i),
              itemBuilder: (context, index) {
                final m = _mandiPrices[index];
                final yourPrice = m['yourPrice'] as int;
                final marketAvg = m['marketAvg'] as int;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(width: 32, height: 32, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                              child: Center(child: Text(m['icon'] as String, style: const TextStyle(fontSize: 16)))),
                          const SizedBox(width: 8),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Today's Mandi Price (eNAM Reference)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87), overflow: TextOverflow.ellipsis),
                              Text(m['crop'] as String, style: TextStyle(fontSize: 11, color: Colors.blue.shade700)),
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                              Text("Your Price", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                              Text("₹$yourPrice", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                              Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                            ])),
                            Container(width: 1, height: 44, color: Colors.grey.shade200),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                Text("Market Avg", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                                Text("₹$marketAvg", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                                Text("per ${m['unit']}", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                              ]),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Column(
              children: [
                Builder(builder: (context) {
                  final m = _mandiPrices[_mandiIndex];
                  final diff = (m['yourPrice'] as int) - (m['marketAvg'] as int);
                  final isFair = diff.abs() <= ((m['marketAvg'] as int) * 0.05);
                  final isAbove = diff > 0;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(isFair ? Icons.check_circle_outline : (isAbove ? Icons.trending_up : Icons.trending_down), color: Colors.green, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                          Text(isFair ? "Fair Price" : (isAbove ? "Above Market" : "Below Market"), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                          Text("Compared to market average", style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                        ])),
                        const SizedBox(width: 8),
                        Text("${diff >= 0 ? '+' : ''}₹$diff", style: TextStyle(color: diff >= 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_mandiPrices.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _mandiIndex == i ? 18 : 6, height: 6,
                    decoration: BoxDecoration(color: _mandiIndex == i ? Colors.blue : Colors.blue.shade200, borderRadius: BorderRadius.circular(3)),
                  )),
                ),
                const SizedBox(height: 6),
                Text("Powered by eNAM Market Insights", style: TextStyle(fontSize: 11, color: Colors.blue.shade600, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Text("🔍", style: TextStyle(fontSize: 48)),
          const SizedBox(height: 14),
          const Text("No listings found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 6),
          Text("Try adjusting your filters", style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: _clearFilters,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: const Text("Clear Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 18),
              Row(children: [
                const Text("Filters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(onPressed: () { setState(_clearFilters); setModalState(() {}); }, child: const Text("Clear All", style: TextStyle(color: Colors.green))),
              ]),
              const SizedBox(height: 16),
              _buildFilterSection("Crop Type", _cropFilters, _selectedCrop, (v) { setState(() => _selectedCrop = v); setModalState(() {}); }),
              const SizedBox(height: 16),
              _buildFilterSection("Location", _locationFilters, _selectedLocation, (v) { setState(() => _selectedLocation = v); setModalState(() {}); }),
              const SizedBox(height: 16),
              _buildFilterSection("Price Range", _priceFilters, _selectedPriceRange, (v) { setState(() => _selectedPriceRange = v); setModalState(() {}); }),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Apply Filters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: options.map((opt) {
            final isSel = selected == opt;
            return GestureDetector(
              onTap: () { onSelect(opt); HapticFeedback.selectionClick(); },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSel ? Colors.green : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSel ? Colors.green : Colors.grey.shade300),
                ),
                child: Text(opt, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: isSel ? FontWeight.w600 : FontWeight.normal, fontSize: 13)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showCropPicker(BuildContext ctx)     => _showPickerSheet(ctx, "Crop Type",    _cropFilters,     _selectedCrop,       (v) => setState(() => _selectedCrop = v));
  void _showLocationPicker(BuildContext ctx) => _showPickerSheet(ctx, "Location",     _locationFilters, _selectedLocation,   (v) => setState(() => _selectedLocation = v));
  void _showPricePicker(BuildContext ctx)    => _showPickerSheet(ctx, "Price Range",  _priceFilters,    _selectedPriceRange, (v) => setState(() => _selectedPriceRange = v));

  void _showPickerSheet(BuildContext ctx, String title, List<String> options, String current, Function(String) onSelect) {
    showModalBottomSheet(
      context: ctx, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            ...options.map((opt) => ListTile(
              title: Text(opt),
              trailing: current == opt ? const Icon(Icons.check_rounded, color: Colors.green) : null,
              onTap: () { onSelect(opt); HapticFeedback.selectionClick(); Navigator.pop(ctx); },
            )),
          ],
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context, Map<String, dynamic> listing, String type) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent, isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                    child: Center(child: Text(listing['farmerEmoji'] as String, style: const TextStyle(fontSize: 26)))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(listing['farmerName'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  if (listing['verified'] as bool)
                    Row(children: const [Icon(Icons.verified_rounded, color: Colors.green, size: 13), SizedBox(width: 3), Text("Verified Farmer", style: TextStyle(color: Colors.green, fontSize: 12))])
                  else
                    Text("Unverified", style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber.shade200)),
                  child: Row(children: [const Icon(Icons.star_rounded, color: Colors.amber, size: 14), const SizedBox(width: 3), Text("${listing['rating']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey.shade100),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionDetailChip("Crop",  listing['crop'] as String),
                _ActionDetailChip("Price", "₹${listing['price']}/${listing['unit']}"),
                _ActionDetailChip("Qty",   listing['qty'] as String),
              ],
            ),
            const SizedBox(height: 20),
            if (type == 'buy') ...[
              SizedBox(width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  icon: const Icon(Icons.shopping_cart_rounded, size: 18),
                  label: const Text("Confirm Purchase", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Request sent to ${listing['farmerName']}!"),
                      backgroundColor: Colors.green, behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade100)),
                child: Row(children: [const Icon(Icons.swap_horiz_rounded, color: Colors.orange, size: 18), const SizedBox(width: 8), const Expanded(child: Text("Barter lets you exchange your produce instead of paying cash.", style: TextStyle(fontSize: 13, color: Colors.black54)))]),
              ),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade600, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                  label: const Text("Propose Barter", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Barter proposal sent to ${listing['farmerName']}!"),
                      backgroundColor: Colors.orange.shade700, behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ));
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;
  const _FilterChip({required this.label, this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = value != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? Colors.green.shade300 : Colors.grey.shade300),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(isActive ? value! : label, style: TextStyle(fontSize: 13, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal, color: isActive ? Colors.green.shade700 : Colors.black54)),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: isActive ? Colors.green.shade600 : Colors.grey),
        ]),
      ),
    );
  }
}

class _ActionDetailChip extends StatelessWidget {
  final String label;
  final String value;
  const _ActionDetailChip(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
      const SizedBox(height: 3),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
    ]);
  }
}

class _ListingCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final VoidCallback onBuy;
  final VoidCallback onBarter;
  const _ListingCard({required this.data, required this.index, required this.onBuy, required this.onBarter});

  @override
  State<_ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<_ListingCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.index * 80), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final badgeColor = Color(d['badgeColor'] as int);

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 14, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [

              // ── LOCAL ASSET IMAGE ──
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  children: [
                    Image.asset(
                      d['assetImage'] as String,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        height: 180,
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade400])),
                        child: const Center(child: Text("🌿", style: TextStyle(fontSize: 50))),
                      ),
                    ),

                    // Rating
                    Positioned(top: 12, right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)]),
                        child: Row(children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                          const SizedBox(width: 3),
                          Text("${d['rating']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ),

                    // Badge
                    Positioned(top: 12, left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(20)),
                        child: Text(d['badge'] as String, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    // Location
                    Positioned(bottom: 12, left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [
                          const Icon(Icons.location_on_rounded, color: Colors.white, size: 12),
                          const SizedBox(width: 3),
                          Text(d['location'] as String, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),

              // ── CONTENT ──
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Farmer row
                    Row(children: [
                      Container(width: 36, height: 36,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: Center(child: Text(d['farmerEmoji'] as String, style: const TextStyle(fontSize: 20)))),
                      const SizedBox(width: 8),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(d['farmerName'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        if (d['verified'] as bool)
                          Row(children: const [Icon(Icons.verified_rounded, color: Colors.green, size: 12), SizedBox(width: 3), Text("Verified Farmer", style: TextStyle(color: Colors.green, fontSize: 11))])
                        else
                          Text("Unverified", style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                      ]),
                      const Spacer(),
                      Text(d['qty'] as String, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ]),

                    const SizedBox(height: 10),

                    // Crop name
                    Text(d['crop'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),

                    const SizedBox(height: 4),

                    // Price
                    RichText(text: TextSpan(children: [
                      TextSpan(text: "₹${d['price']}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                      TextSpan(text: " /${d['unit']}",  style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                    ])),

                    const SizedBox(height: 14),

                    // ── BARTER + BUY ──
                    Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.onBarter,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(Icons.swap_horiz_rounded, color: Colors.orange.shade700, size: 18),
                              const SizedBox(width: 6),
                              Text("Barter", style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.w600, fontSize: 14)),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: widget.onBuy,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))],
                            ),
                            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text("Buy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                            ]),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}