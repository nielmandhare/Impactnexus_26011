import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListCreatedPage extends StatefulWidget {
  final String item;
  final String quantity;
  final String qualityTier; // "A", "B", or "C"
  final double estimatedValue;
  final double visibilityRadius;
  final double expiresInDays;

  const ListCreatedPage({
    super.key,
    required this.item,
    required this.quantity,
    required this.qualityTier,
    required this.estimatedValue,
    required this.visibilityRadius,
    required this.expiresInDays,
  });

  @override
  State<ListCreatedPage> createState() => _ListCreatedPageState();
}

class _ListCreatedPageState extends State<ListCreatedPage>
    with TickerProviderStateMixin {
  late AnimationController _checkAnim;
  late AnimationController _contentAnim;
  late Animation<double> _checkScale;
  late Animation<double> _checkOpacity;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;

  @override
  void initState() {
    super.initState();

    _checkAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _contentAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkAnim, curve: Curves.elasticOut),
    );
    _checkOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _checkAnim,
          curve: const Interval(0.0, 0.4, curve: Curves.easeIn)),
    );

    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentAnim, curve: Curves.easeOut),
    );
    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(parent: _contentAnim, curve: Curves.easeOut),
        );

    // Staggered entry
    _checkAnim.forward();
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _contentAnim.forward();
    });

    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _checkAnim.dispose();
    _contentAnim.dispose();
    super.dispose();
  }

  String get _tierLabel => 'Tier ${widget.qualityTier}';

  Color get _tierColor {
    switch (widget.qualityTier) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.orange;
      default:
        return Colors.deepOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: SafeArea(
        child: Column(
          children: [
            // ─── BACK BUTTON ROW ───
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black87, size: 20),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ─── SUCCESS ICON ───
                    ScaleTransition(
                      scale: _checkScale,
                      child: FadeTransition(
                        opacity: _checkOpacity,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.35),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 52,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ─── TITLE ───
                    FadeTransition(
                      opacity: _contentFade,
                      child: SlideTransition(
                        position: _contentSlide,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Listing Created!",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("🎉", style: TextStyle(fontSize: 22)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Your offer is now visible to nearby farmers",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ─── DETAILS CARD ───
                    FadeTransition(
                      opacity: _contentFade,
                      child: SlideTransition(
                        position: _contentSlide,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // ─ Estimated Value + Quality row ─
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left: KrishiPoints
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Estimated Value",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          widget.estimatedValue
                                              .toStringAsFixed(0),
                                          style: const TextStyle(
                                            fontSize: 38,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            height: 1.1,
                                          ),
                                        ),
                                        Text(
                                          "KrishiPoints",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Right: Quality tier
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Quality",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: _tierColor.withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          border: Border.all(
                                              color: _tierColor.withOpacity(0.3)),
                                        ),
                                        child: Text(
                                          _tierLabel,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _tierColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),
                              Divider(color: Colors.grey.shade100, height: 1),
                              const SizedBox(height: 18),

                              // ─ Listing details rows ─
                              _DetailRow(
                                label: "Item:",
                                value: widget.item.isEmpty ? "—" : widget.item,
                              ),
                              const SizedBox(height: 12),
                              _DetailRow(
                                label: "Quantity:",
                                value: widget.quantity.isEmpty
                                    ? "—"
                                    : "${widget.quantity} kg",
                              ),
                              const SizedBox(height: 12),
                              _DetailRow(
                                label: "Visibility:",
                                value:
                                "${widget.visibilityRadius.toInt()} km radius",
                              ),
                              const SizedBox(height: 12),
                              _DetailRow(
                                label: "Expires in:",
                                value:
                                "${widget.expiresInDays.toInt()} ${widget.expiresInDays == 1 ? 'day' : 'days'}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ─── BUTTONS ───
                    FadeTransition(
                      opacity: _contentFade,
                      child: SlideTransition(
                        position: _contentSlide,
                        child: Column(
                          children: [
                            // View My Listings
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  // Navigate to listings page
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                },
                                child: const Text(
                                  "View My Listings",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Create Another Listing
                            TextButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Create Another Listing",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}