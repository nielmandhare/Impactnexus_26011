/*
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 15)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 14)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 15, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 16)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 14)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*
*//*

*/
/*
*//*
*/
/*

*//*

*/
/*
*//*
*/
/*
*//*

*/
/*

*//*
*/
/*

*//*

*/
/*
*//*
*/
/*
*//*

*/
/*
*//*
*/
/*

*//*

*/
/*

*//*
*/
/*
*//*

*/
/*

*//*
*/
/*

*//*

*/
/*

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              /// BG
              Image.asset(
                "assets/images/farm.png",
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                  ),
                ),
              ),

              /// DARK OVERLAY
              Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              /// SHARE BADGE
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),

              /// CONTENT
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 8),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ]),
                      ]),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.grass, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ]),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.trending_up, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ]),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 4),
                      const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}


*//*
*/
/*
*//*

*/
/*
*//*
*/
/*

*//*

*/
/*
*//*
*/
/*
*//*

*/
/*

*//*
*/
/*

*//*

*/
/*

import 'package:flutter/material.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              /// BG
              Image.asset(
                "assets/images/farm.png",
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                  ),
                ),
              ),

              /// DARK OVERLAY
              Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              /// SHARE BADGE
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),

              /// CONTENT
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 8),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ]),
                      ]),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.grass, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ]),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.trending_up, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ]),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 4),
                      const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*
*//*

*/
/*
*//*
*/
/*

*//*

*/
/*

import 'package:flutter/material.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: heroHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF43A047)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            /// BG
            Image.asset(
              "assets/images/farm.png",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// SHARE BADGE
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            /// CONTENT
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ]),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.grass, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 4),
                    const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*
*//*

*/
/*

import 'package:flutter/material.dart';
import 'list.dart';
import 'marketplace.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: heroHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF43A047)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return GestureDetector(
                onTap: () {
                  if (action["label"] == "View Marketplace") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplacePage()));
                  } else if (action["label"] == "Sell Produce") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateListingPage()));
                  }
                },
                child: _HoverContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          action["image"]!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => Container(
                            height: 80, width: 80,
                            decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                            child: const Icon(Icons.eco, color: Colors.green, size: 36),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          action["label"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            /// BG
            Image.asset(
              "assets/images/farm.png",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// SHARE BADGE
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            /// CONTENT
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ]),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.grass, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 4),
                    const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  if (i == 1) {
                    // Marketplace
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MarketplacePage()),
                    );
                  } else {
                    setState(() => _selectedNavIndex = i);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*

*//*

*/
/*
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 15)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 14)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 15, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 16)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 14)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*
*//*

*/
/*
*//*
*/
/*

*//*

*/
/*
*//*
*/
/*
*//*

*/
/*

*//*
*/
/*

*//*

*/
/*

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              /// BG
              Image.asset(
                "assets/images/farm.png",
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                  ),
                ),
              ),

              /// DARK OVERLAY
              Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              /// SHARE BADGE
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),

              /// CONTENT
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 8),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ]),
                      ]),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.grass, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ]),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.trending_up, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ]),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 4),
                      const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}


*//*
*/
/*
*//*

*/
/*
*//*
*/
/*

*//*

*/
/*

import 'package:flutter/material.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              /// BG
              Image.asset(
                "assets/images/farm.png",
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                  ),
                ),
              ),

              /// DARK OVERLAY
              Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              /// SHARE BADGE
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),

              /// CONTENT
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 8),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ]),
                      ]),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.grass, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ]),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.trending_up, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ]),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 4),
                      const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*
*//*

*/
/*

import 'package:flutter/material.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: heroHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF43A047)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            /// BG
            Image.asset(
              "assets/images/farm.png",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// SHARE BADGE
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            /// CONTENT
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ]),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.grass, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 4),
                    const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*

import 'package:flutter/material.dart';
import 'list.dart';
import 'marketplace.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: heroHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF43A047)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return GestureDetector(
                onTap: () {
                  if (action["label"] == "View Marketplace") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplacePage()));
                  } else if (action["label"] == "Sell Produce") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateListingPage()));
                  }
                },
                child: _HoverContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          action["image"]!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => Container(
                            height: 80, width: 80,
                            decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                            child: const Icon(Icons.eco, color: Colors.green, size: 36),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          action["label"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            /// BG
            Image.asset(
              "assets/images/farm.png",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// SHARE BADGE
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            /// CONTENT
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ]),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.grass, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 4),
                    const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/barter');
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  if (i == 1) {
                    // Marketplace
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MarketplacePage()),
                    );
                  } else {
                    setState(() => _selectedNavIndex = i);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*

*/
/*
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 15)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 14)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 15, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 16)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 14)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*
*//*
*/
/**//*


import 'package:flutter/material.dart';
import 'list.dart';
import 'marketplace.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: heroHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF43A047)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return GestureDetector(
                onTap: () {
                  if (action["label"] == "View Marketplace") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplacePage()));
                  } else if (action["label"] == "Sell Produce") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateListingPage()));
                  }
                },
                child: _HoverContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          action["image"]!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => Container(
                            height: 80, width: 80,
                            decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                            child: const Icon(Icons.eco, color: Colors.green, size: 36),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          action["label"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            /// BG
            Image.asset(
              "assets/images/farm.png",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// SHARE BADGE
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            /// CONTENT
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ]),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.grass, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 4),
                    const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/barter');
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  if (i == 1) {
                    // Marketplace
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MarketplacePage()),
                    );
                  } else if (i == 3) {
                    // Community
                    Navigator.pushNamed(context, '/community');
                  } else {
                    setState(() => _selectedNavIndex = i);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*/
/*
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 15)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 14)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 15, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 16)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 14)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*
*/
/*
*//*

*/
/*

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              /// BG
              Image.asset(
                "assets/images/farm.png",
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                  ),
                ),
              ),

              /// DARK OVERLAY
              Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              /// SHARE BADGE
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),

              /// CONTENT
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 8),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ]),
                      ]),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.grass, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ]),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.trending_up, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ]),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 4),
                      const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}


*//*
*/
/*

import 'package:flutter/material.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              /// BG
              Image.asset(
                "assets/images/farm.png",
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                  ),
                ),
              ),

              /// DARK OVERLAY
              Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              /// SHARE BADGE
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),

              /// CONTENT
              Positioned(
                bottom: 0, left: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                        ),
                        const SizedBox(width: 8),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ]),
                      ]),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.grass, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ]),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                            child: const Row(children: [
                              Icon(Icons.trending_up, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ]),
                          ),
                        ]),
                      ),

                      const SizedBox(height: 4),
                      const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*//*

import 'package:flutter/material.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: heroHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF43A047)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HoverContainer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        action["image"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 80, width: 80,
                          decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.eco, color: Colors.green, size: 36),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        action["label"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            /// BG
            Image.asset(
              "assets/images/farm.png",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// SHARE BADGE
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            /// CONTENT
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ]),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.grass, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 4),
                    const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import 'list.dart';
import 'marketplace.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;

  late AnimationController _headerController;
  late AnimationController _cardController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  final List<Map<String, dynamic>> _mandiPrices = [
    {"crop": "Wheat", "cropHindi": "गेहूं", "price": "₹2150", "change": "+2.5%", "up": true, "high": "₹2250", "low": "₹2050", "avg": "₹2150"},
    {"crop": "Rice", "cropHindi": "चावल", "price": "₹1980", "change": "-1.2%", "up": false, "high": "₹2100", "low": "₹1950", "avg": "₹2000"},
    {"crop": "Soybean", "cropHindi": "सोयाबीन", "price": "₹4320", "change": "+3.8%", "up": true, "high": "₹4500", "low": "₹4200", "avg": "₹4350"},
    {"crop": "Cotton", "cropHindi": "कपास", "price": "₹6800", "change": "+1.1%", "up": true, "high": "₹7000", "low": "₹6700", "avg": "₹6850"},
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () { if (mounted) _cardController.forward(); });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: FadeTransition(opacity: _headerFade, child: SlideTransition(position: _headerSlide, child: _buildHeroHeader()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: SlideTransition(position: _cardSlide, child: _buildWalletBanner()))),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildQuickActions())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildAIInsightBanner())),
              SliverToBoxAdapter(child: FadeTransition(opacity: _cardFade, child: _buildMandiSection())),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final topPadding = MediaQuery.of(context).padding.top;
      final heroHeight = topPadding + 260.0;

      return SizedBox(
        height: heroHeight,
        child: Stack(
          children: [
            /// BG IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Image.asset("assets/images/crop.png", height: heroHeight, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: heroHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
              ),
            ),

            /// GRADIENT
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              child: Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.65), Colors.black.withOpacity(0.05)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HoverContainer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Row(children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text("Akola, Maharashtra", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 15),
                            ]),
                          ),
                        ),
                        _HoverContainer(
                          child: Stack(children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3))),
                              child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                            ),
                            Positioned(right: 0, top: 0, child: Container(
                              width: 18, height: 18,
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                            )),
                          ]),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("👋", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 3),
                    const Text("Namaskar, Farmer", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const Text("Welcome to कृषीSetu", style: TextStyle(color: Colors.white70, fontSize: 14)),

                    const SizedBox(height: 14),

                    /// WEATHER CARD
                    _HoverContainer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: Row(children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.cloud, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("28°C", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Partly Cloudy", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ]),
                          const Spacer(),
                          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Row(children: [
                              Icon(Icons.water_drop_outlined, color: Color(0xFF1E88E5), size: 13),
                              SizedBox(width: 3),
                              Text("60%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                            ]),
                            Text("Rain Forecast", style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text("Expected at 3 PM", style: TextStyle(color: Color(0xFF1E88E5), fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWalletBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: _HoverContainer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.asset("assets/images/farm.png", height: 115, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF43A047)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                ),
              ),
              Container(
                height: 115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(children: [
                          Icon(Icons.wallet, color: Colors.white70, size: 14),
                          SizedBox(width: 5),
                          Text("कृषीPoints Wallet", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const SizedBox(height: 5),
                        const Row(children: [
                          Text("₹0", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 17),
                        ]),
                        const Text("Available Balance", style: TextStyle(color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  // ─────────────────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      {"label": "Sell Produce", "image": "assets/images/1.png"},
      {"label": "Barter Exchange", "image": "assets/images/2.png"},
      {"label": "View Marketplace", "image": "assets/images/3.png"},
      {"label": "Community", "image": "assets/images/4.png"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// eNAM badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Text(
                "Powered by eNAM Market Insights",
                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return GestureDetector(
                onTap: () {
                  if (action["label"] == "View Marketplace") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplacePage()));
                  } else if (action["label"] == "Sell Produce") {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateListingPage()));
                  }
                },
                child: _HoverContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          action["image"]!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => Container(
                            height: 80, width: 80,
                            decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                            child: const Icon(Icons.eco, color: Colors.green, size: 36),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          action["label"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // AI INSIGHT BANNER
  // ─────────────────────────────────────────────────────────
  Widget _buildAIInsightBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            /// BG
            Image.asset(
              "assets/images/farm.png",
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            /// SHARE BADGE
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Share", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),

            /// CONTENT
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: Colors.amber.shade600, shape: BoxShape.circle),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("AI Market Insights", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Text("Best Selling Opportunity Today", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ]),
                    ]),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.grass, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Wheat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Pune Mandi", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: const Row(children: [
                            Icon(Icons.trending_up, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text("+8%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ]),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 4),
                    const Text("Price rising today", style: TextStyle(color: Colors.white70, fontSize: 12)),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateListingPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("Sell or Barter Now", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: Colors.green, size: 17),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildMandiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Live Mandi Prices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            _HoverContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Text("View All", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.green, size: 14),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_mandiPrices.asMap().entries.map((entry) =>
            Padding(padding: const EdgeInsets.only(bottom: 12), child: _MandiCard(data: entry.value, delay: entry.key * 80))
        ).toList()),
      ]),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home_rounded, "label": "Home"},
      {"icon": Icons.search_rounded, "label": "Marketplace"},
      {"icon": Icons.swap_horiz_rounded, "label": "Barter"},
      {"icon": Icons.people_outline_rounded, "label": "Community"},
      {"icon": Icons.person_outline_rounded, "label": "Profile"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isCenter = i == 2;
              final isSelected = _selectedNavIndex == i;

              if (isCenter) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/barter');
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade700 : Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Icon(item["icon"] as IconData, color: Colors.white, size: 26),
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  if (i == 1) {
                    // Marketplace
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MarketplacePage()),
                    );
                  } else if (i == 3) {
                    // Community
                    Navigator.pushNamed(context, '/community');
                  } else if (i == 4) {
                    // Profile
                    Navigator.pushNamed(context, '/profile');
                  } else {
                    setState(() => _selectedNavIndex = i);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item["icon"] as IconData, color: isSelected ? Colors.green : Colors.grey, size: 22),
                    const SizedBox(height: 3),
                    Text(item["label"] as String, style: TextStyle(fontSize: 10, color: isSelected ? Colors.green : Colors.grey, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER CONTAINER ───
class _HoverContainer extends StatefulWidget {
  final Widget child;
  const _HoverContainer({required this.child});
  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─── MANDI CARD ───
class _MandiCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  const _MandiCard({required this.data, required this.delay});
  @override
  State<_MandiCard> createState() => _MandiCardState();
}

class _MandiCardState extends State<_MandiCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final bool isUp = widget.data["up"] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.data["crop"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                        Text(widget.data["cropHindi"] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isUp ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isUp ? Colors.green.shade200 : Colors.red.shade200),
                        ),
                        child: Row(children: [
                          Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: isUp ? Colors.green : Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.data["change"] as String, style: TextStyle(color: isUp ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                        ]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(widget.data["price"] as String, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatChip(label: "High", value: widget.data["high"] as String),
                      _StatChip(label: "Low", value: widget.data["low"] as String),
                      _StatChip(label: "Avg", value: widget.data["avg"] as String),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}