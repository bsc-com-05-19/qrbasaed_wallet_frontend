// profile_page.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static String routeName = "/user_profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 18, // Change 20 to your desired text size
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF564FA1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                _username,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Color(0xFF564FA1),
                ),
                title: Text('Account Settings'),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF564FA1),
                ),
                onTap: () {
                  // Navigate to account settings
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.history,
                  color: Color(0xFF564FA1),
                ),
                title: Text('Payment History'),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF564FA1),
                ),
                onTap: () {
                  // Navigate to order history
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Color(0xFF564FA1),
                ),
                title: Text('Logout'),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF564FA1),
                ),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('session_id');
                  await prefs.remove('username');
                  await prefs.remove('email');
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
