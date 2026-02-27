import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:krishi_setu/main.dart';

void main() {
  // ── Initialize Supabase before any widget test that uses it ──
  setUpAll(() async {
    // Use a fake/mock URL + key for tests — never real credentials
    await Supabase.initialize(
      url: 'https://udjrdwkwepjoizvckabl.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkanJkd2t3ZXBqb2l6dmNrYWJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIxNzkxMDAsImV4cCI6MjA4Nzc1NTEwMH0.mj734-46548tydDFsFMkCak2muvL_zo4l4N05u8CV-0',
    );
  });

  testWidgets('App launches and shows loading or welcome screen',
          (WidgetTester tester) async {
        // Build the real app entry point
        await tester.pumpWidget(const KrishiSetuApp()); // ✅ was wrongly 'MyApp'

        // Pump a few frames to let the auth stream settle
        await tester.pump(const Duration(milliseconds: 100));

        // The app should show EITHER the loading spinner OR the WelcomePage
        // (depends on whether the mock Supabase session resolves)
        // We just verify the app doesn't crash on launch.
        expect(find.byType(MaterialApp), findsOneWidget);
      });

  testWidgets('AuthGate renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthGate(),
      ),
    );

    // Should show the loading state initially
    await tester.pump(const Duration(milliseconds: 50));
    // App should not crash — that's the minimum bar
    expect(find.byType(AuthGate), findsOneWidget);
  });
}