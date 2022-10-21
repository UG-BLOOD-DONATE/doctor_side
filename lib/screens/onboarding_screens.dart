//import 'package:image/image.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/first_screens/blood_page.dart';
import 'package:ug_blood_donate/screens/first_screens/loginScreen.dart';
import 'package:ug_blood_donate/screens/first_screens/register.dart';

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showHome ? const Request_page() : const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = LiquidController();
  bool isLastPage = false;

  @override
  // void dispose() {
  //   controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: Stack(
          children: [
            LiquidSwipe(
              enableSideReveal: true,
              slideIconWidget: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPageChangeCallback: (index) {
                setState(() => isLastPage =
                    controller.currentPage == 3); //=> isLastPage = index == 2
              },
              liquidController: controller,
              pages: [
                Container(
                  color: const Color.fromARGB(255, 239, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Vector.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      const Text(
                        'Find Blood Donors',
                        style: TextStyle(
                          color: Color.fromARGB(255, 244, 247, 246),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      const Text(
                        'Locate a blood donor nearby',
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 251, 251),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 18, 8, 203),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/rafiki.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      Text(
                        'Find Blood Donors',
                        style: TextStyle(
                          color: Color.fromARGB(255, 242, 247, 246),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      const Text(
                        'Locate a blood donor nearby',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 248, 248),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   color: Colors.lightBlueAccent,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         'assets/images/Blood-Donation.jpg',
                //         fit: BoxFit.cover,
                //         width: double.infinity,
                //       ),
                //       const SizedBox(
                //         height: 44,
                //       ),
                //       Text(
                //         'Find Blood Donors',
                //         style: TextStyle(
                //           color: Color.fromARGB(255, 242, 247, 246),
                //           fontSize: 32,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 44,
                //       ),
                //       const Text(
                //         'Locate a blood donor nearby',
                //         style: TextStyle(
                //           color: Color.fromARGB(255, 250, 248, 248),
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  color: const Color.fromARGB(255, 8, 203, 34),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 34,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ugblood donate.png',
                                width: 300,
                                height: 350,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'You can donate for ones in need and  ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[90]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'request blood if you need. ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[900]),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return const LoginScreen();
                                      }),
                                    );
                                  },
                                  child: const Text(
                                    'LOG IN',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.focused))
                                        return Colors.pink[300];
                                      if (states
                                          .contains(MaterialState.hovered))
                                        return Colors.pink[300];
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return Colors.pink[300];
                                      return null; // Defer to the widget's default.
                                    }),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.pink),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return const RegisterPage();
                                      }),
                                    );
                                  },
                                  child: const Text(
                                    'REGISTER',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.focused))
                                        return Colors.pink[300];
                                      if (states
                                          .contains(MaterialState.hovered))
                                        return Colors.pink[300];
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return Colors.pink[300];
                                      return null; // Defer to the widget's default.
                                    }),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.pink),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                    builder: (_) => const Request_page(),
                  ),
                );
              },
              child: const Text(
                'Get started',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
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
                        controller.jumpToPage(page: 2);
                      },
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: controller.currentPage,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        page: index,
                      ),
                    ),
                    // Center(
                    //   child: SmoothPageIndicator(
                    //     controller: controller,
                    //     count: 3,
                    //   effect: WormEffect(
                    //     spacing: 16,
                    //     dotColor: Colors.black26,
                    //     activeDotColor: Colors.teal.shade700,
                    //   ),
                    //   onDotClicked: (index) => controller.animateToPage(
                    //     index,
                    //     duration: const Duration(milliseconds: 500),
                    //     curve: Curves.easeInOut,
                    //   ),
                    // ),
                    // ),
                    TextButton(
                      child: const Text('NEXT'),
                      onPressed: () {
                        final page = controller.currentPage + 1;
                        controller.animateToPage(
                          page: page > 4 ? 0 : page,
                          duration: 300,
                          // duration: const Duration(milliseconds: 500),
                          // curve: Curves.easeInOut,
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
