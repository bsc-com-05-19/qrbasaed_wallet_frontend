import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'login.dart';
import 'notification.dart';
import 'profile_page.dart';
import 'scanner.dart';
import 'settings.dart';
import 'receipt.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isLoading = false;
  bool _isButtonPressed = false;
  int _selectedIndex = 0; // Track selected nav icon index
  String _username = '';
  String _balance = '';

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
    _loadUserData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
      _balance = prefs.getString('balance') ?? '0.00'; // Load balance here
    });
  }

  Future<void> _loginUser(String username, String password) async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    // Simulate authentication
    await Future.delayed(Duration(seconds: 2));
    final isLoggedIn = true; // Simulated successful authentication

    if (isLoggedIn) {
      // If user is already logged in, re-authenticate them in the background
      try {
        var response = await http.post(
          Uri.parse('https://f50b-41-70-47-51.ngrok-free.app/login'),
          body: {'username': username, 'password': password},
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          var sessionId = data['sessionId'];
          var user = data['user'];

          await prefs.setString('session_id', sessionId);
          await prefs.setString('balance', user['balance']);

          setState(() {
            _balance = user['balance'];
          });
        } else {
          print('Login failed: ${response.statusCode}');
          // Handle login failure
        }
      } catch (e) {
        print('Error during login: $e');
        // Handle error during login
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Navigate to login page if user is not logged in
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  Future<void> _fetchBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    if (username != null && password != null) {
      await _loginUser(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: SingleChildScrollView(
              child: Container(
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
                                'IZEpay',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ProfilePage()),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFD4B150),
                              child: Icon(
                                Icons.person,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          color: Color(0xFFD4B150),
                          fontSize: 38,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFFD4B150),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            color: Color(0xFFD4B150),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xFF7870B3),
                            ),
                            child: Row(
                              children: [
                                SlideTransition(
                                  position: _offsetAnimation,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await _fetchBalance();
                                      setState(() {
                                        _isButtonPressed = !_isButtonPressed;
                                        _isLoading = false;
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
                                if (_isLoading)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                if (_isButtonPressed && !_isLoading)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16),
                                    child: Text(
                                      'MWK $_balance',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
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
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: double.infinity,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 1.0, // Make image cover the full width of the screen
              ),
              items: [
                'assets/slide1.jpg',
                'assets/slide2.jpg',
                'assets/slide3.png',
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // Add border radius
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Clip the image with border radius
                        child: Image.asset(i, fit: BoxFit.cover), // Use BoxFit.cover to cover the whole width
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const QRCodeScannerPage()));
        },
        backgroundColor: const Color(0xFF564FA1),
        child: const Icon(Icons.qr_code_2),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF564FA1).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavButton(Icons.home_filled, 'Home', index: 0),
                _buildNavButton(Icons.notifications, 'Notifications', index: 1),
                _buildNavButton(Icons.receipt_long, 'Receipts', index: 2),
                _buildNavButton(Icons.settings, 'Settings', index: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientCircle(String initial, String name) {
    return GestureDetector(
      onTap: () {
        // Add navigation logic for each recipient here
      },
      child: Column(
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
      ),
    );
  }

  Widget _buildRecipientCircleImage(String imagePath, String name) {
    return GestureDetector(
      onTap: () {
        // Add navigation logic for each recipient here
      },
      child: Column(
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
      ),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
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
              size: 25,
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? const Color(0xFF564FA1) : Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
