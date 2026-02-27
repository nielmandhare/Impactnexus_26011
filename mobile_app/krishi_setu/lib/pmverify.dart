import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'verifysuccess.dart';

class PMVerifyPage extends StatefulWidget {
  const PMVerifyPage({super.key});

  @override
  State<PMVerifyPage> createState() => _PMVerifyPageState();
}

class _PMVerifyPageState extends State<PMVerifyPage>
    with TickerProviderStateMixin {

  // ── CONTROLLERS ──
  final TextEditingController _mobileController = TextEditingController();
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
  List.generate(6, (_) => FocusNode());

  // ── STATE ──
  bool _isNumberComplete = false;
  bool _otpSent = false;
  bool _isSendingOtp = false;
  bool _isVerifying = false;
  bool _otpError = false;
  String _generatedOtp = '';
  int _resendSeconds = 30;
  Timer? _resendTimer;

  // ── ANIMATIONS ──
  late AnimationController _otpPanelAnim;
  late Animation<double> _otpPanelFade;
  late Animation<Offset> _otpPanelSlide;

  late AnimationController _shakeAnim;
  late Animation<double> _shakeOffset;

  @override
  void initState() {
    super.initState();

    _mobileController.addListener(() {
      setState(() {
        _isNumberComplete = _mobileController.text.length == 10;
      });
    });

    _otpPanelAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _otpPanelFade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _otpPanelAnim, curve: Curves.easeOut));
    _otpPanelSlide =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
            CurvedAnimation(parent: _otpPanelAnim, curve: Curves.easeOut));

    _shakeAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _shakeOffset = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _shakeAnim, curve: Curves.elasticIn));
  }

  @override
  void dispose() {
    _mobileController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    _otpPanelAnim.dispose();
    _shakeAnim.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  // ── Generate a 6-digit OTP ──
  String _generateOtp() {
    final rng = Random();
    return List.generate(6, (_) => rng.nextInt(10)).join();
  }

  // ── Send OTP ──
  Future<void> _sendOtp() async {
    if (!_isNumberComplete || _isSendingOtp) return;

    setState(() => _isSendingOtp = true);
    HapticFeedback.mediumImpact();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    _generatedOtp = _generateOtp();

    // Clear previous OTP input
    for (final c in _otpControllers) {
      c.clear();
    }

    setState(() {
      _isSendingOtp = false;
      _otpSent = true;
      _otpError = false;
      _resendSeconds = 30;
    });

    _otpPanelAnim.forward(from: 0);
    _startResendTimer();

    // Auto-focus first OTP box
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _otpFocusNodes[0].requestFocus();
    });

    // Show the OTP in a snackbar (for demo/testing purposes)
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.sms_outlined, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                "OTP sent: $_generatedOtp  (demo)",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  // ── Resend timer ──
  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          t.cancel();
        }
      });
    });
  }

  // ── Get entered OTP ──
  String get _enteredOtp =>
      _otpControllers.map((c) => c.text).join();

  bool get _isOtpComplete => _enteredOtp.length == 6;

  // ── Verify OTP → navigate ──
  Future<void> _verifyOtp() async {
    if (!_isOtpComplete || _isVerifying) return;

    setState(() => _isVerifying = true);
    HapticFeedback.mediumImpact();

    await Future.delayed(const Duration(milliseconds: 900));

    if (_enteredOtp == _generatedOtp) {
      // ✅ Correct
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VerifySuccessPage()),
        );
      }
    } else {
      // ❌ Wrong
      HapticFeedback.heavyImpact();
      setState(() {
        _isVerifying = false;
        _otpError = true;
      });
      _shakeAnim.forward(from: 0).then((_) => _shakeAnim.reverse());
    }

    if (mounted) setState(() => _isVerifying = false);
  }

  // ── OTP box key handler ──
  void _onOtpChanged(int index, String value) {
    setState(() => _otpError = false);

    if (value.isNotEmpty) {
      if (index < 5) {
        _otpFocusNodes[index + 1].requestFocus();
      } else {
        _otpFocusNodes[index].unfocus();
        // Auto-verify when last digit entered
        if (_isOtpComplete) _verifyOtp();
      }
    }
  }

  void _onOtpKeyDown(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _otpControllers[index].text.isEmpty &&
        index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
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
                        Icons.verified_user_outlined,
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
                    Text(
                      _otpSent
                          ? "Enter the OTP sent to your mobile"
                          : "Boost your trust score instantly",
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              if (!_otpSent) ...[
                /// BENEFIT CARDS (visible only before OTP sent)
                _BenefitCard(
                  icon: Icons.verified_user_outlined,
                  iconColor: Colors.green,
                  title: "Get Verified Badge",
                  subtitle:
                  "Show farmers you're a registered PM-KISAN beneficiary",
                ),
                const SizedBox(height: 14),
                _BenefitCard(
                  icon: Icons.trending_up,
                  iconColor: Colors.green,
                  title: "Increase Trust Score",
                  subtitle: "Instant +30 points boost (50 → 80)",
                ),
                const SizedBox(height: 36),
              ] else ...[
                const SizedBox(height: 10),
              ],

              /// ─── MOBILE INPUT SECTION ───
              const Text(
                "PM-KISAN Registered Mobile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              /// MOBILE INPUT + SEND OTP BUTTON ROW
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _otpSent
                              ? Colors.green
                              : _isNumberComplete
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
                        enabled: !_otpSent,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter mobile number",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: _otpSent
                                ? Colors.green
                                : Colors.grey.shade400,
                          ),
                          suffixIcon: _otpSent
                              ? const Icon(Icons.check_circle,
                              color: Colors.green, size: 20)
                              : null,
                          counterText: "",
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // ── SEND OTP / CHANGE button ──
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _otpSent
                            ? Colors.grey.shade200
                            : _isNumberComplete
                            ? Colors.green
                            : Colors.grey.shade300,
                        foregroundColor:
                        _otpSent ? Colors.black54 : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: _otpSent
                          ? () {
                        // Change number
                        setState(() {
                          _otpSent = false;
                          _otpError = false;
                          _resendTimer?.cancel();
                          for (final c in _otpControllers) {
                            c.clear();
                          }
                        });
                        _otpPanelAnim.reverse();
                      }
                          : (_isNumberComplete && !_isSendingOtp)
                          ? _sendOtp
                          : null,
                      child: _isSendingOtp
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                          : Text(
                        _otpSent ? "Change" : "Send OTP",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                _otpSent
                    ? "OTP sent to +91 ${_mobileController.text}"
                    : "Enter the mobile number registered with PM-KISAN",
                style: TextStyle(
                  fontSize: 12,
                  color: _otpSent ? Colors.green.shade600 : Colors.grey,
                ),
              ),

              /// ─── OTP PANEL (slides in after OTP sent) ───
              if (_otpSent)
                FadeTransition(
                  opacity: _otpPanelFade,
                  child: SlideTransition(
                    position: _otpPanelSlide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 28),

                        const Text(
                          "Enter OTP",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// OTP BOXES
                        AnimatedBuilder(
                          animation: _shakeAnim,
                          builder: (context, child) {
                            final dx = sin(_shakeOffset.value * pi * 6) * 8;
                            return Transform.translate(
                              offset: Offset(dx, 0),
                              child: child,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(6, (i) {
                              return SizedBox(
                                width: 46,
                                height: 56,
                                child: RawKeyboardListener(
                                  focusNode: FocusNode(),
                                  onKey: (event) => _onOtpKeyDown(i, event),
                                  child: TextField(
                                    controller: _otpControllers[i],
                                    focusNode: _otpFocusNodes[i],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (val) => _onOtpChanged(i, val),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: _otpError
                                          ? Colors.red
                                          : Colors.black87,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      filled: true,
                                      fillColor: _otpControllers[i]
                                          .text
                                          .isNotEmpty
                                          ? _otpError
                                          ? Colors.red.shade50
                                          : Colors.green.shade50
                                          : Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: _otpError
                                              ? Colors.red.shade300
                                              : Colors.grey.shade300,
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: _otpError
                                              ? Colors.red
                                              : Colors.green,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: _otpError
                                              ? Colors.red.shade300
                                              : _otpControllers[i]
                                              .text
                                              .isNotEmpty
                                              ? Colors.green
                                              : Colors.grey.shade300,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Error message
                        AnimatedOpacity(
                          opacity: _otpError ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red, size: 14),
                                SizedBox(width: 6),
                                Text(
                                  "Incorrect OTP. Please try again.",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// RESEND ROW
                        Row(
                          children: [
                            Text(
                              "Didn't receive it? ",
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 13),
                            ),
                            _resendSeconds > 0
                                ? Text(
                              "Resend in ${_resendSeconds}s",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 13),
                            )
                                : GestureDetector(
                              onTap: _sendOtp,
                              child: const Text(
                                "Resend OTP",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        /// VERIFY BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isOtpComplete
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              foregroundColor: Colors.white,
                              elevation: _isOtpComplete ? 3 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed:
                            _isOtpComplete && !_isVerifying
                                ? _verifyOtp
                                : null,
                            child: _isVerifying
                                ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white),
                            )
                                : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.verified_user_outlined,
                                    size: 18),
                                SizedBox(width: 8),
                                Text(
                                  "Verify PM-KISAN Account",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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

              if (!_otpSent) ...[
                const SizedBox(height: 28),

                /// VERIFY BUTTON (before OTP — greyed, prompts user to send OTP first)
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: null,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified_user_outlined, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "Verify PM-KISAN Account",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    "Send OTP first to verify your account",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ),
              ],

              const SizedBox(height: 16),

              /// SKIP
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Skip for now →",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
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

// ─────────────────────────────────────────────────────────
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
                      fontWeight: FontWeight.bold, fontSize: 15),
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