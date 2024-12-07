import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../authentication_screen/login.dart';
import '../../widgets/onboarding_screen_widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Note Down Expenses',
      'subtitle': 'Daily note your expenses to help manage money',
      'image': 'lib/assets/svgImgs/expense_note.svg',
    },
    {
      'title': 'Simple Money Management',
      'subtitle': 'Get your notification or alert when you do over expenses',
      'image': 'lib/assets/svgImgs/money_management.svg',
    },
    {
      'title': 'Easy to Track and Analyse',
      'subtitle': 'Tracking your expense helps ensure you do not overspend',
      'image': 'lib/assets/svgImgs/track_analyse.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  title: _onboardingData[index]['title']!,
                  subtitle: _onboardingData[index]['subtitle']!,
                  image: _onboardingData[index]['image']!,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8,
                width: _currentPage == index ? 20 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.blue
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3C8CE7), Color(0xFF1565C0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "LET'S GO",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
