/*
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'page2.dart';
import 'kisanid.dart';

void main() {
  runApp(const KrishiSetuApp());
}

class KrishiSetuApp extends StatelessWidget {
  const KrishiSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Krishi Setu",

      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const WelcomePage(),
        '/language': (context) => const Page2(),
        '/kisanid': (context) => const KisanIdPage(),
      },
    );
  }
}
//hie niel*//*

import 'package:flutter/material.dart';
import 'welcome.dart';
import 'page2.dart';
import 'kisanid.dart';
import 'barter.dart';

void main() {
  runApp(const KrishiSetuApp());
}

class KrishiSetuApp extends StatelessWidget {
  const KrishiSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Krishi Setu",

      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const WelcomePage(),
        '/language': (context) => const Page2(),
        '/kisanid': (context) => const KisanIdPage(),
        '/barter': (context) => const BarterPage(),
      },
    );
  }
}*/
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'page2.dart';
import 'kisanid.dart';
import 'barter.dart';

void main() {
  runApp(const KrishiSetuApp());
}

class KrishiSetuApp extends StatelessWidget {
  const KrishiSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Krishi Setu",

      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const WelcomePage(),
        '/language': (context) => const Page2(),
        '/kisanid': (context) => const KisanIdPage(),
        '/barter': (context) => const BarterPage(),
      },
    );
  }
}