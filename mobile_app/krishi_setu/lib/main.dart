import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'welcome.dart';
import 'page2.dart';
import 'kisanid.dart';
import 'pmverify.dart';
import 'verifysuccess.dart';

// ── Easy global accessor (use anywhere in app) ──
// Usage: supabase.auth.currentUser
final supabase = Supabase.instance.client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://udjrdwkwepjoizvckabl.supabase.co',
    // 🔑 IMPORTANT: Rotate this key in Supabase Dashboard → Settings → API
    // after sharing it publicly. Even though anon keys are client-safe,
    // it's good practice to rotate after accidental exposure.
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkanJkd2t3ZXBqb2l6dmNrYWJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIxNzkxMDAsImV4cCI6MjA4Nzc1NTEwMH0.mj734-46548tydDFsFMkCak2muvL_zo4l4N05u8CV-0',
  );

  runApp(const KrishiSetuApp());
}

class KrishiSetuApp extends StatelessWidget {
  const KrishiSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krishi Setu',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      // ── AuthGate decides the initial screen based on session ──
      home: const AuthGate(),
      routes: {
        '/welcome':      (context) => const WelcomePage(),
        '/language':     (context) => const Page2(),
        '/kisanid':      (context) => const KisanIdPage(),
        '/verify':       (context) => const PMVerifyPage(),
        '/verifySuccess':(context) => const VerifySuccessPage(),
      },
    );
  }
}

// ─────────────────────────────────────────────────────────
// AUTH GATE
// Listens to Supabase auth state and redirects automatically.
//
//  • No session  → WelcomePage (onboarding / login)
//  • Has session → KisanIdPage (main app home)
//
// This also handles the case where the app restarts after
// a successful login — user won't see the OTP screen again.
// ─────────────────────────────────────────────────────────
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // Supabase auth state stream
  late final Stream<AuthState> _authStream;

  @override
  void initState() {
    super.initState();
    _authStream = supabase.auth.onAuthStateChange;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: _authStream,
      builder: (context, snapshot) {

        // ── Still waiting for first auth event ──
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF0FAF0),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.green),
                  SizedBox(height: 16),
                  Text(
                    'Loading Krishi Setu...',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Check session ──
        final session = snapshot.hasData
            ? snapshot.data!.session
            : supabase.auth.currentSession;

        if (session != null) {
          // User is logged in → go to main app
          debugPrint('✅ AuthGate: session found for ${session.user.phone}');
          return const KisanIdPage();
        } else {
          // No session → go to onboarding
          debugPrint('ℹ️ AuthGate: no session, showing WelcomePage');
          return const WelcomePage();
        }
      },
    );
  }
}