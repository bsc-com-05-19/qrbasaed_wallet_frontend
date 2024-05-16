import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home.dart'; // Import the home.dart file

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Initial position
      end: Offset.zero, // Final position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat.yMd().format(DateTime.now());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.2,
        decoration: const BoxDecoration(
          color: Color(0xFF564FA1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 10,
            left: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 33.12,
                    height: 24,
                    child: Image.asset('assets/data/izepay_logo2.png'),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'izepay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    currentDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'MWK 1,034,875.00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Francis Eneya',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Container(
                    width: 204.2,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF7870B3),
                      ),
                    ),
                    child: Stack(
                      children: [
                        SlideTransition(
                          position: _offsetAnimation,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_isButtonPressed) {
                                _controller.forward().then((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
                                  );
                                });
                              } else {
                                _controller.reverse(); // Reverse the animation
                              }
                              setState(() {
                                _isButtonPressed = !_isButtonPressed; // Toggle button state
                              });
                              // Add your button functionality here
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF564FA1),
                              backgroundColor: const Color(0xFFD4B150),
                              minimumSize: const Size(101, 34),
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(color: Color(0xFFD4B150)),
                              ),
                            ),
                            child: const Text(
                              'Balance',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
