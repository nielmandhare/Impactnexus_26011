import 'dart:async';
import 'package:flutter/material.dart';
import 'kisanid.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with TickerProviderStateMixin {

  int selectedIndex = -1;
  int visibleItems = 0;

  final List<Map<String, String>> languages = [
    {"code": "IN", "native": "हिंदी",   "name": "Hindi"},
    {"code": "IN", "native": "मराठी",   "name": "Marathi"},
    {"code": "IN", "native": "தமிழ்",   "name": "Tamil"},
    {"code": "IN", "native": "తెలుగు",  "name": "Telugu"},
    {"code": "IN", "native": "ಕನ್ನಡ",   "name": "Kannada"},
    {"code": "🌐", "native": "English", "name": "English"},
  ];

  late AnimationController logoController;
  late Animation<double> logoScale;
  late Animation<double> logoFade;

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));

    logoScale = Tween(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: logoController, curve: Curves.easeOutBack));

    logoFade = Tween(begin: 0.0, end: 1.0).animate(logoController);

    logoController.forward();

    _startStaggerAnimation();
  }

  void _startStaggerAnimation() async {
    await Future.delayed(const Duration(milliseconds: 800));
    for (int i = 0; i < languages.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      if (mounted) setState(() => visibleItems++);
    }
  }

  @override
  void dispose() {
    logoController.dispose();
    super.dispose();
  }

  // ── All languages navigate to KisanIdPage ──
  // In the future, pass the selected language code to KisanIdPage
  // so it can render in the correct language.
  void _onLanguageTapped(int index) {
    setState(() => selectedIndex = index);

    // Brief delay so the selection highlight is visible before navigating
    Future.delayed(const Duration(milliseconds: 180), () {
      if (!mounted) return;
      Navigator.pushReplacement(    // ✅ pushReplacement so back doesn't return to language screen
        context,
        MaterialPageRoute(
          builder: (context) => const KisanIdPage(),
          // TODO: pass language code when KisanIdPage supports i18n
          // builder: (context) => KisanIdPage(language: languages[index]["name"]),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            // ── LOGO ──
            FadeTransition(
              opacity: logoFade,
              child: ScaleTransition(
                scale: logoScale,
                child: Image.asset(
                  "assets/images/krishi_logo.png",
                  height: 120,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Connecting Farmers to Trade, Trust, and Growth.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.language, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  "Choose Your Language",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ── LANGUAGE GRID ──
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: languages.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {

                  // Not yet animated in — show empty placeholder
                  if (index >= visibleItems) return const SizedBox();

                  final bool isSelected = selectedIndex == index;

                  return AnimatedScale(
                    scale: isSelected ? 1.07 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () => _onLanguageTapped(index), // ✅ all languages navigate
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.green
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              languages[index]["code"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              languages[index]["native"]!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              languages[index]["name"]!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ── HELPLINE BOX ──
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text("Using a feature phone?"),
                  SizedBox(height: 8),
                  Text(
                    "1800-XXX-XXXX",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "IVR Helpline (24x7)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}