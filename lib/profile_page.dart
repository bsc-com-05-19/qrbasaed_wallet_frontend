import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_page.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static String routeName = "/user_profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _balance = '';
  String _email = '';
  String _clientId = '';
  String _secretKey = '';
  String _cardName = '';
  String _cardNumber = '';
  String _cardSecurityCode = '';
  String _cardExpiry = '';

  bool _showAccountDetails = false;

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
      _email = prefs.getString('email') ?? 'N/A';
      _clientId = prefs.getString('client_id') ?? 'N/A';
      _secretKey = prefs.getString('secret_key') ?? 'N/A';
      _cardName = prefs.getString('card_name') ?? 'N/A';
      _cardNumber = prefs.getString('card_number') ?? 'N/A';
      _cardSecurityCode = prefs.getString('card_security_code') ?? 'N/A';
      _cardExpiry = prefs.getString('card_expiry') ?? 'N/A';
    });
  }

  void _toggleAccountDetails() {
    setState(() {
      _showAccountDetails = !_showAccountDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
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
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Color(0xFF564FA1),
                ),
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
                title: Text('Account Details'),
                trailing: Icon(
                  _showAccountDetails ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Color(0xFF564FA1),
                ),
                onTap: _toggleAccountDetails,
              ),
              if (_showAccountDetails) _buildAccountDetails(),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Color(0xFF564FA1),
                ),
                title: Text('Account Settings'),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF564FA1),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountDetails() {
    return Card(
      shadowColor: Color(0xFF564FA1),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Email', _email),
            Divider(),
            _buildDetailItem('Card Name', _cardName),
            Divider(),
            _buildDetailItem('Card Number', _cardNumber),
            Divider(),
            _buildDetailItem('Card Security Code', _cardSecurityCode),
            Divider(),
            _buildDetailItem('Card Expiry', _cardExpiry),
            Divider(),
            _buildDetailItem('Balance', _balance),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF564FA1),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
