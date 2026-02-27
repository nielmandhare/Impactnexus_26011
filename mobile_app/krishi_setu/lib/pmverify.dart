/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PMVerifyPage extends StatefulWidget {
  const PMVerifyPage({super.key});

  @override
  State<PMVerifyPage> createState() => _PMVerifyPageState();
}

class _PMVerifyPageState extends State<PMVerifyPage> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isNumberComplete = false;

  @override
  void initState() {
    super.initState();
    _mobileController.addListener(() {
      setState(() {
        _isNumberComplete = _mobileController.text.length == 10;
      });
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 16),

              /// BACK BUTTON
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 30),

              /// TOP ICON + TITLE
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "PM-KISAN Verification",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Boost your trust score instantly",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// BENEFIT CARD 1
              _BenefitCard(
                icon: Icons.verified_user_outlined,
                iconColor: Colors.green,
                title: "Get Verified Badge",
                subtitle: "Show farmers you're a registered PM-KISAN beneficiary",
              ),

              const SizedBox(height: 14),

              /// BENEFIT CARD 2
              _BenefitCard(
                icon: Icons.trending_up,
                iconColor: Colors.green,
                title: "Increase Trust Score",
                subtitle: "Instant +30 points boost (50 → 80)",
              ),

              const SizedBox(height: 36),

              /// MOBILE LABEL
              const Text(
                "PM-KISAN Registered Mobile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              /// MOBILE INPUT
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _isNumberComplete
                        ? Colors.green
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Enter mobile number",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: Colors.grey.shade400,
                    ),
                    counterText: "",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Enter the mobile number registered with PM-KISAN",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 28),

              /// VERIFY BUTTON
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isNumberComplete
                        ? Colors.green
                        : Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    elevation: _isNumberComplete ? 3 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _isNumberComplete
                      ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Verifying PM-KISAN account..."),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Verify PM-KISAN Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// SKIP
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Skip for now →",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// BOTTOM INFO BOX
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("💡", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Not a PM-KISAN beneficiary? You can still register! Your trust score will start at 50 and increase with successful transactions.",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _BenefitCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade100),
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'verifysuccess.dart';

class PMVerifyPage extends StatefulWidget {
  const PMVerifyPage({super.key});

  @override
  State<PMVerifyPage> createState() => _PMVerifyPageState();
}

class _PMVerifyPageState extends State<PMVerifyPage> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isNumberComplete = false;

  @override
  void initState() {
    super.initState();
    _mobileController.addListener(() {
      setState(() {
        _isNumberComplete = _mobileController.text.length == 10;
      });
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 16),

              /// BACK BUTTON
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 30),

              /// TOP ICON + TITLE
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "PM-KISAN Verification",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Boost your trust score instantly",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// BENEFIT CARD 1
              _BenefitCard(
                icon: Icons.verified_user_outlined,
                iconColor: Colors.green,
                title: "Get Verified Badge",
                subtitle: "Show farmers you're a registered PM-KISAN beneficiary",
              ),

              const SizedBox(height: 14),

              /// BENEFIT CARD 2
              _BenefitCard(
                icon: Icons.trending_up,
                iconColor: Colors.green,
                title: "Increase Trust Score",
                subtitle: "Instant +30 points boost (50 → 80)",
              ),

              const SizedBox(height: 36),

              /// MOBILE LABEL
              const Text(
                "PM-KISAN Registered Mobile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              /// MOBILE INPUT
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _isNumberComplete
                        ? Colors.green
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Enter mobile number",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: Colors.grey.shade400,
                    ),
                    counterText: "",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Enter the mobile number registered with PM-KISAN",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 28),

              /// VERIFY BUTTON
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isNumberComplete
                        ? Colors.green
                        : Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    elevation: _isNumberComplete ? 3 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _isNumberComplete
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifySuccessPage(),
                      ),
                    );
                  }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Verify PM-KISAN Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// SKIP
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Skip for now →",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// BOTTOM INFO BOX
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("💡", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Not a PM-KISAN beneficiary? You can still register! Your trust score will start at 50 and increase with successful transactions.",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _BenefitCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade100),
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}