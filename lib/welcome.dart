import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrbased_frontend/home.dart';
import 'package:qrbased_frontend/login.dart';


class WelcomeScreen extends StatefulWidget {
  static String routeName = "/welcome";

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Set status bar color to match the background color
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );

    // Navigate to the sign-in screen after a delay
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage(),
      )
      );
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Reset the status bar color when the splash screen page is disposed
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xFF564FA1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Fixed padding values
    const double topPadding = 200; // Adjust as needed
    const double bottomPadding = 100; // Adjust as needed

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Small logo and text
            Positioned(
              bottom: 0, // Align to the bottom of the screen
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 2), // Duration of the animation
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return AnimatedOpacity(
                        opacity: value,
                        duration: const Duration(seconds: 2), // Duration of the fade-in effect
                        child: child,
                      );
                    },
                    child: Container(
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.08,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.23,
                            height: screenSize.height * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/data/small_logo.png", // Path to the PNG file
                                  width: screenSize.width * 0.05, // Adjust the size as needed
                                  height: screenSize.height * 0.05, // Adjust the size as needed
                                ),
                                SizedBox(width: screenSize.width * 0.02), // Add spacing between logo and text
                                Text(
                                  'IZEpay',
                                  style: TextStyle(
                                    color: const Color(0xFFD4B150),
                                    fontSize: screenSize.width * 0.047,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Falling logo
            Positioned(
              bottom: screenSize.height * 0.2, // Adjust position as needed
              child: Image.asset(
                "assets/data/logo.png", // Path to the logo PNG file
                width: screenSize.width * 0.5, // Adjust the size as needed
                height: screenSize.height * 0.5, // Adjust the size as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
