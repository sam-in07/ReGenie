import 'package:flutter/material.dart';
import 'package:regenie/presentation/Home/Pages/home_screen.dart';
import 'package:regenie/presentation/widgets/primary_button.dart';
import 'package:regenie/presentation/widgets/app_text_style.dart';
import 'package:regenie/presentation/widgets/colors.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/daily.png",
      "title": "Daily Eco Challenges",
      "subtitle":
      "Complete fun and simple daily tasks to reduce your carbon footprint and make a positive impact on the planet.",
    },
    {
      "image": "assets/images/earn.png",
      "title": "Earn Eco Points",
      "subtitle": "Track your progress and earn points for every challenge you complete. Compete with friends and climb the leaderboard!",
    },
    {
      "image": "assets/images/aieco.png",
      "title": "AI Eco Tips",
      "subtitle":
      "Get personalized advice from ReGenie, your AI companion. Ask questions and learn how to live a more sustainable lifestyle.",
    },
  ];


  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()), // ✅ routes to your HomeScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFD1F1DD),
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToHome,
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),

            // PageView (slides)
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset(
                          page['image']!,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 30),


                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: AppTextstyle.textStyle24darkblackW600,
                        ),
                        const SizedBox(height: 12),

                        // Subtitle text
                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: AppTextstyle.textStyle16greyW400,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),


            // Dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.green
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: PrimaryButton(
                height: 50,
                width: size.width,
                radius: 12,
                title: _currentPage == _pages.length - 1
                    ? "Get Started"
                    : "Next",
                color: AppColors.appButtonColor2,
                onTap: _nextPage,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
