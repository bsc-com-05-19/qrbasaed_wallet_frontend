import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrbased_frontend/balance_screen.dart';
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
            height: MediaQuery.of(context).size.height / 2.2,
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
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications, color: Colors.white),
                            onPressed: () {
                              // Handle notification icon tap
                            },
                          ),
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/data/profile_picture.png'),
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
                    'Francis Yeneya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 204.2,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                              foregroundColor: const Color(0xFF564FA1),
                              backgroundColor: const Color(0xFFD4B150),
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
                              child: Text(
                                'My QR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
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
                          _buildRecipientCircleImage('assets/data/recipient_image.jpg', 'King Bres_'), // Profile image for King Bres_
                          _buildRecipientCircle('E', 'ED'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BarChart(
                          BarChartData(
                            barGroups: [
                              _buildBarChartGroup(0, 4, 3), // Monday
                              _buildBarChartGroup(1, 2, 2), // Tuesday
                              _buildBarChartGroup(2, 3, 4), // Wednesday
                              _buildBarChartGroup(3, 5, 3), // Thursday
                              _buildBarChartGroup(4, 6, 5), // Friday
                              _buildBarChartGroup(5, 4, 4), // Saturday
                              _buildBarChartGroup(6, 3, 2), // Sunday
                            ],
                            titlesData: FlTitlesData(
                              leftTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (context, value) => const TextStyle(
                                  color: Color(0xFF564FA1),
                                  fontSize: 12,
                                ),
                                getTitles: (double value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'Mon';
                                    case 1:
                                      return 'Tue';
                                    case 2:
                                      return 'Wed';
                                    case 3:
                                      return 'Thu';
                                    case 4:
                                      return 'Fri';
                                    case 5:
                                      return 'Sat';
                                    case 6:
                                      return 'Sun';
                                    default:
                                      return '';
                                  }
                                },
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavIcon(Icons.account_balance_wallet),
                _buildNavIcon(Icons.qr_code, active: true),
                _buildNavIcon(Icons.receipt_long),
                _buildNavIcon(Icons.settings),
              ],
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
          backgroundColor: Color(0xFFD4B150),
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

  BarChartGroupData _buildBarChartGroup(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y1,
          colors: [Color(0xFFD4B150)],
          width: 8,
        ),
        BarChartRodData(
          y: y2,
          colors: [Color(0xFF564FA1)],
          width: 8,
        ),
      ],
    );
  }

  Widget _buildNavIcon(IconData icon, {bool active = false}) {
    return Icon(
      icon,
      color: active ? const Color(0xFF564FA1) : Colors.grey,
      size: 28,
    );
  }
}
