/*
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with TickerProviderStateMixin {

  int selectedIndex = -1;

  final List<Map<String, String>> languages = [
    {"code": "IN", "native": "हिंदी", "name": "Hindi"},
    {"code": "IN", "native": "मराठी", "name": "Marathi"},
    {"code": "IN", "native": "தமிழ்", "name": "Tamil"},
    {"code": "IN", "native": "తెలుగు", "name": "Telugu"},
    {"code": "IN", "native": "ಕನ್ನಡ", "name": "Kannada"},
    {"code": "🌐", "native": "English", "name": "English"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// LOGO
            Image.asset(
              "assets/images/krishi_logo.png",
              height: 120,
            ),

            const SizedBox(height: 10),

            const Text(
              "Connecting Farmers to Trade, Trust, and Growth.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// TITLE
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
                )
              ],
            ),

            const SizedBox(height: 30),

            /// LANGUAGE GRID
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

                  bool isSelected = selectedIndex == index;

                  return AnimatedScale(
                    scale: isSelected ? 1.05 : 1,
                    duration: const Duration(milliseconds: 200),

                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },

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
                            )
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
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// HELPLINE
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
                  )
                ],
              ),

              child: Column(
                children: const [

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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
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
    {"code": "IN", "native": "हिंदी", "name": "Hindi"},
    {"code": "IN", "native": "मराठी", "name": "Marathi"},
    {"code": "IN", "native": "தமிழ்", "name": "Tamil"},
    {"code": "IN", "native": "తెలుగు", "name": "Telugu"},
    {"code": "IN", "native": "ಕನ್ನಡ", "name": "Kannada"},
    {"code": "🌐", "native": "English", "name": "English"},
  ];

  late AnimationController logoController;
  late Animation<double> logoScale;
  late Animation<double> logoFade;

  @override
  void initState() {
    super.initState();

    /// LOGO ANIMATION
    logoController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

    logoScale = Tween(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: logoController, curve: Curves.easeOutBack));

    logoFade = Tween(begin: 0.0, end: 1.0).animate(logoController);

    logoController.forward();

    /// LANGUAGE CARD STAGGER ANIMATION
    startStaggerAnimation();
  }

  void startStaggerAnimation() async {
    await Future.delayed(const Duration(milliseconds: 800));

    for (int i = 0; i < languages.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      setState(() {
        visibleItems++;
      });
    }
  }

  @override
  void dispose() {
    logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// LOGO SPLASH
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
                )
              ],
            ),

            const SizedBox(height: 30),

            /// LANGUAGE GRID
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

                  if (index >= visibleItems) {
                    return const SizedBox();
                  }

                  bool isSelected = selectedIndex == index;

                  return AnimatedScale(
                    scale: isSelected ? 1.07 : 1,
                    duration: const Duration(milliseconds: 200),

                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        if (languages[index]["name"] == "English") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KisanIdPage(),
                            ),
                          );
                        }
                      },

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
                            )
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
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// HELPLINE
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
                  )
                ],
              ),
              child: Column(
                children: const [

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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}