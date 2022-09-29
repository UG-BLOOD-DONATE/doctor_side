import 'package:image/image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/first_screens/blood_page.dart';

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome,}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showHome ? Request_page() :OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          controller: controller,
          children: [
            Container(
              color: Colors.green.shade100,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Request_page(),
                  ),
                );
              },
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              height: 80,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('SKIP'),
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.teal.shade700,
                        ),
                        onDotClicked: (index) => controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                      ),
                    ),
                    TextButton(
                      child: const Text('NEXT'),
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ]),
            ),
    );
  }

  // Widget buildPage({
  //   required Colors color,
  //   required String urlImage,
  //   required String title,
  //   required String subtitle,
  // }) =>
  //     Container(
  //       color: color,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset(
  //             urlImage,
  //             fit: BoxFit.cover,
  //             width: double.infinity,
  //           ),
  //           const SizedBox(
  //             height: 64,
  //           ),
  //           Text(
  //             title,
  //             style: TextStyle(
  //               color: Colors.teal.shade700,
  //               fontSize: 32,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 64,
  //           ),
  //           Text(
  //             subtitle,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 22,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}
