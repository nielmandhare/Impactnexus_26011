/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RuPayPage extends StatefulWidget {
  const RuPayPage({super.key});

  @override
  State<RuPayPage> createState() => _RuPayPageState();
}

class _RuPayPageState extends State<RuPayPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _cardController = TextEditingController();
  bool _isCardComplete = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _cardController.addListener(() {
      setState(() {
        _isCardComplete = _cardController.text.length == 4;
      });
    });

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _openRuPaySite() async {
    final Uri url = Uri.parse(
        "https://www.idbi.bank.in/hindi/rupay-kisan-debit-card.aspx");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open RuPay site");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF0),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
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
                          width: 76,
                          height: 76,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "Link Your RuPay Kisan Card",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Connect your RuPay Kisan card to activate wallet",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// BENEFIT CARD 1
                  _BenefitCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "कृषीPoints Wallet",
                    subtitle: "Earn and spend points through barter transactions",
                  ),

                  const SizedBox(height: 14),

                  /// BENEFIT CARD 2
                  _BenefitCard(
                    icon: Icons.shield_outlined,
                    title: "100% Secure Payments",
                    subtitle: "RuPay certified security for all transactions",
                  ),

                  const SizedBox(height: 34),

                  /// INPUT LABEL
                  const Text(
                    "RuPay Kisan Card Last 4 Digits",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// CARD INPUT
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _isCardComplete
                            ? Colors.green
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: _isCardComplete ? 8 : 4,
                          color: _isCardComplete
                              ? Colors.green.withOpacity(0.15)
                              : Colors.black.withOpacity(0.04),
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: TextField(
                      controller: _cardController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 8,
                      ),
                      decoration: InputDecoration(
                        hintText: "_ _ _ _",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          letterSpacing: 8,
                          fontSize: 20,
                        ),
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: _isCardComplete
                              ? Colors.green
                              : Colors.grey.shade400,
                        ),
                        suffixIcon: _isCardComplete
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : null,
                        counterText: "",
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Enter the last 4 digits of your RuPay Kisan card",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 28),

                  /// LINK CARD BUTTON
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isCardComplete
                            ? Colors.green
                            : Colors.grey.shade300,
                        foregroundColor: Colors.white,
                        elevation: _isCardComplete ? 4 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _isCardComplete
                          ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                            Text("Linking RuPay Kisan Card..."),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                          : null,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Link Card & Activate Wallet",
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

                  const SizedBox(height: 14),

                  /// DON'T HAVE A CARD BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: BorderSide(
                            color: Colors.green.shade300, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text(
                        "Don't have a card?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: _openRuPaySite,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// SKIP
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
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

                  /// SECURITY NOTE
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade100),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🔒", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Your card details are encrypted and stored securely. We never store full card numbers.",
                            style: TextStyle(
                              color: Colors.deepOrange,
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
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _BenefitCard({
    required this.icon,
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
            child: Icon(icon, color: Colors.green, size: 22),
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
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
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
import 'package:url_launcher/url_launcher.dart';
import 'walletactivated.dart';

class RuPayPage extends StatefulWidget {
  const RuPayPage({super.key});

  @override
  State<RuPayPage> createState() => _RuPayPageState();
}

class _RuPayPageState extends State<RuPayPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _cardController = TextEditingController();
  bool _isCardComplete = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _cardController.addListener(() {
      setState(() {
        _isCardComplete = _cardController.text.length == 4;
      });
    });

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _openRuPaySite() async {
    final Uri url = Uri.parse(
        "https://www.idbi.bank.in/hindi/rupay-kisan-debit-card.aspx");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open RuPay site");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF0),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
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
                          width: 76,
                          height: 76,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "Link Your RuPay Kisan Card",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Connect your RuPay Kisan card to activate wallet",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// BENEFIT CARD 1
                  _BenefitCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "कृषीPoints Wallet",
                    subtitle: "Earn and spend points through barter transactions",
                  ),

                  const SizedBox(height: 14),

                  /// BENEFIT CARD 2
                  _BenefitCard(
                    icon: Icons.shield_outlined,
                    title: "100% Secure Payments",
                    subtitle: "RuPay certified security for all transactions",
                  ),

                  const SizedBox(height: 34),

                  /// INPUT LABEL
                  const Text(
                    "RuPay Kisan Card Last 4 Digits",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// CARD INPUT
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _isCardComplete
                            ? Colors.green
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: _isCardComplete ? 8 : 4,
                          color: _isCardComplete
                              ? Colors.green.withOpacity(0.15)
                              : Colors.black.withOpacity(0.04),
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: TextField(
                      controller: _cardController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 8,
                      ),
                      decoration: InputDecoration(
                        hintText: "_ _ _ _",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          letterSpacing: 8,
                          fontSize: 20,
                        ),
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: _isCardComplete
                              ? Colors.green
                              : Colors.grey.shade400,
                        ),
                        suffixIcon: _isCardComplete
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : null,
                        counterText: "",
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Enter the last 4 digits of your RuPay Kisan card",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 28),

                  /// LINK CARD BUTTON
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isCardComplete
                            ? Colors.green
                            : Colors.grey.shade300,
                        foregroundColor: Colors.white,
                        elevation: _isCardComplete ? 4 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _isCardComplete
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const WalletActivatedPage(),
                          ),
                        );
                      }
                          : null,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Link Card & Activate Wallet",
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

                  const SizedBox(height: 14),

                  /// DON'T HAVE A CARD BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: BorderSide(
                            color: Colors.green.shade300, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text(
                        "Don't have a card?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: _openRuPaySite,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// SKIP
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
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

                  /// SECURITY NOTE
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade100),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🔒", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Your card details are encrypted and stored securely. We never store full card numbers.",
                            style: TextStyle(
                              color: Colors.deepOrange,
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
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _BenefitCard({
    required this.icon,
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
            child: Icon(icon, color: Colors.green, size: 22),
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
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}