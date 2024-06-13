import 'package:flutter/material.dart';
import 'package:qrbased_frontend/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static String routeName = "/user_profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _balance = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
      _balance = prefs.getString('balance') ?? 'no balance';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 18, // Change 20 to your desired text size
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF564FA1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
              const SizedBox(height: 20),
              Text(
                _username,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              Text(
                _balance,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Color(0xFF564FA1),
                ),
                title: const Text('Account Settings'),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF564FA1),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.history,
                  color: Color(0xFF564FA1),
                ),
                title: const Text('Payment History'),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF564FA1),
                ),
                onTap: () {
                  // Navigate to payment history
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Color(0xFF564FA1),
                ),
                title: const Text('Logout'),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF564FA1),
                ),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('session_id');
                  await prefs.remove('username');
                  await prefs.remove('email');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
