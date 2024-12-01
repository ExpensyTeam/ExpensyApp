import 'package:expensy/views/screens/overview_screen/overview.dart';
import 'package:expensy/views/screens/savings_screen/savings.dart';
import 'package:flutter/material.dart';
import 'views/screens/onboarding_screen/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Overview(),
        '/saving': (context) => Savings(),
        // '/profile': (context) => const ProfileScreen(),
      },
      title: 'Onboarding & Login',
      theme: ThemeData.dark(),
      home: const OnboardingScreen(),
    );
  }
}
