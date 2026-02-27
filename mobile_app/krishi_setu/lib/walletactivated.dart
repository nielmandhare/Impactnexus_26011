import 'dart:math';
import 'package:flutter/material.dart';
import 'homepage.dart';

class WalletActivatedPage extends StatefulWidget {
  const WalletActivatedPage({super.key});

  @override
  State<WalletActivatedPage> createState() => _WalletActivatedPageState();
}

class _WalletActivatedPageState extends State<WalletActivatedPage>
    with TickerProviderStateMixin {

  late AnimationController _confettiController;
  late AnimationController _contentController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;

  final List<_ConfettiParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    /// GENERATE CONFETTI PARTICLES
    for (int i = 0; i < 60; i++) {
      _particles.add(_ConfettiParticle(random: _random));
    }

    /// CONFETTI ANIMATION
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    /// CONTENT ANIMATION
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutBack),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _contentController.forward();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF0),
      body: Stack(
        children: [

          /// CONFETTI LAYER
          AnimatedBuilder(
            animation: _confettiController,
            builder: (context, child) {
              return CustomPaint(
                painter: _ConfettiPainter(
                  particles: _particles,
                  progress: _confettiController.value,
                  screenSize: size,
                ),
                child: const SizedBox.expand(),
              );
            },
          ),

          /// MAIN CONTENT
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [

                      const SizedBox(height: 16),

                      /// BACK BUTTON
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black87),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// SUCCESS ICON
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.35),
                                blurRadius: 20,
                                spreadRadius: 4,
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 46,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// TITLE
                      const Text(
                        "Wallet Activated! 🎉",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Your कृषीPoints wallet is ready to use",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),

                      const SizedBox(height: 28),

                      /// WALLET CARD
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// CARD HEADER
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const [
                                  Row(
                                    children: [
                                      Icon(Icons.wallet,
                                          color: Colors.white70, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "कृषीPoints Wallet",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.credit_card,
                                      color: Colors.white54),
                                ],
                              ),

                              const SizedBox(height: 22),

                              /// BALANCE
                              const Text(
                                "Available Balance",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                ),
                              ),
                              const Text(
                                "KrishiPoints",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13),
                              ),

                              const SizedBox(height: 22),

                              /// DIVIDER
                              Container(
                                  height: 1,
                                  color: Colors.white.withOpacity(0.2)),

                              const SizedBox(height: 16),

                              /// LINKED CARD ROW
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Linked Card",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "RuPay Kisan **** 2345",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.white30, width: 1),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.shield_outlined,
                                            color: Colors.white70, size: 14),
                                        SizedBox(width: 4),
                                        Text(
                                          "Secured",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// FEATURE CARDS
                      _FeatureCard(
                        delay: 0,
                        controller: _contentController,
                        icon: Icons.check_box,
                        title: "Start Creating Barter Listings",
                        subtitle:
                        "Offer your produce or equipment to nearby farmers",
                      ),

                      const SizedBox(height: 12),

                      _FeatureCard(
                        delay: 100,
                        controller: _contentController,
                        icon: Icons.check_box,
                        title: "Earn कृषीPoints",
                        subtitle:
                        "Complete verified barter transactions to earn points",
                      ),

                      const SizedBox(height: 12),

                      _FeatureCard(
                        delay: 200,
                        controller: _contentController,
                        icon: Icons.check_box,
                        title: "Spend at Local Shops",
                        subtitle: "Use points like cash at partner merchants",
                      ),

                      const SizedBox(height: 32),

                      /// CTA BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shadowColor: Colors.green.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                                  (route) => false,
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start Using कृषीSetu",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ───────────────────────────── FEATURE CARD ─────────────────────────────
class _FeatureCard extends StatefulWidget {
  final int delay;
  final AnimationController controller;
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.delay,
    required this.controller,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _localCtrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _localCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _localCtrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _localCtrl, curve: Curves.easeOut));

    Future.delayed(
        Duration(milliseconds: 600 + widget.delay), () {
      if (mounted) _localCtrl.forward();
    });
  }

  @override
  void dispose() {
    _localCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.green, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle,
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 12),
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
}

/// ───────────────────────────── CONFETTI ─────────────────────────────
class _ConfettiParticle {
  late double x;
  late double y;
  late double size;
  late Color color;
  late double speed;
  late double angle;
  late double rotation;
  late double rotationSpeed;
  late bool isLeft; // shoot from left or right

  _ConfettiParticle({required Random random}) {
    isLeft = random.nextBool();
    x = isLeft ? 0.0 : 1.0;
    y = random.nextDouble() * 0.3; // start near top
    size = random.nextDouble() * 8 + 5;
    speed = random.nextDouble() * 0.4 + 0.3;
    angle = isLeft
        ? random.nextDouble() * 0.6 + 0.2
        : random.nextDouble() * 0.6 + 2.5;
    rotation = random.nextDouble() * 2 * pi;
    rotationSpeed = (random.nextDouble() - 0.5) * 0.2;
    color = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      const Color(0xFFFFD700),
    ][random.nextInt(8)];
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;
  final Size screenSize;

  _ConfettiPainter({
    required this.particles,
    required this.progress,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;

    for (final p in particles) {
      final t = progress * p.speed * 3;
      if (t > 1.5) continue;

      final dx = cos(p.angle) * t * size.width * 0.6;
      final dy = sin(p.angle) * t * size.height * 0.5 +
          0.5 * 9.8 * t * t * size.height * 0.04;

      final px = p.x * size.width + (p.isLeft ? dx : -dx);
      final py = p.y * size.height + dy;

      if (py > size.height + 20) continue;

      final opacity = (1.0 - (t / 1.5)).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = p.color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(px, py);
      canvas.rotate(p.rotation + p.rotationSpeed * t * 20);

      final rect = Rect.fromCenter(
          center: Offset.zero, width: p.size, height: p.size * 0.5);
      canvas.drawRect(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}