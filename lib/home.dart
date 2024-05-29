import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrbased_frontend/balance_screen.dart';
import 'package:qrbased_frontend/qrScannerPage.dart';
import 'package:qrbased_frontend/notification.dart';
import 'package:qrbased_frontend/receipt.dart';
import 'package:qrbased_frontend/settings.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isButtonPressed = false;
  int _selectedIndex = 0; // Track selected nav icon index

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
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
    String currentDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.3,
            decoration: const BoxDecoration(
              color: Color(0xFF564FA1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 10,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            'izePay',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/data/profile_picture.jpg'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        currentDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Francis Eneya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 204.1,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xFF7870B3),
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
                                        MaterialPageRoute(builder: (context) => const BalanceScreen()),
                                      );
                                    });
                                  } else {
                                    _controller.reverse();
                                  }
                                  setState(() {
                                    _isButtonPressed = !_isButtonPressed;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFFD4B150),
                                  onPrimary: const Color(0xFF564FA1),
                                  minimumSize: const Size(111, 35),
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Color(0xFFC8C4E2)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.swap_vert),
                                iconSize: 24,
                                color: Color(0xFFD4B150),
                                onPressed: null,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Top Recipients',
                                style: TextStyle(
                                  color: Color(0xFF564FA1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF564FA1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.qr_code_scanner,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'My QR',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildRecipientCircle('W', 'Wify'),
                          _buildRecipientCircle('J', 'Jack Boss'),
                          _buildRecipientCircleImage('assets/data/profile_picture.jpg', 'King Bres_'),
                          _buildRecipientCircle('E', 'ED'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildNavButton(Icons.notifications, '', index: 0),
                          _buildNavButton(Icons.qr_code_2, '', index: 1),
                          _buildNavButton(Icons.receipt_long, '', index: 2),
                          _buildNavButton(Icons.settings, '', index: 3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCircle(String initial, String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFFD4B150),
          child: Text(
            initial,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF564FA1),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientCircleImage(String imagePath, String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF564FA1),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, String label, {required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; 
        });
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerPage()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ReceiptPage()));
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            break;
        }
      },
      child: SizedBox(
        width: 65, 
        height: 60, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? const Color(0xFF564FA1) : Colors.grey,
              size: 28,
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? const Color(0xFF564FA1) : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
