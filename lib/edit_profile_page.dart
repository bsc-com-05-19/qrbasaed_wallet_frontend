import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _cardNameController;
  late TextEditingController _cardNumberController;
  late TextEditingController _cardSecurityCodeController;
  late TextEditingController _cardExpiryController;
  late String _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'N/A';
      _emailController = TextEditingController(text: prefs.getString('email') ?? 'N/A');
      _cardNameController = TextEditingController(text: prefs.getString('card_name') ?? 'N/A');
      _cardNumberController = TextEditingController(text: prefs.getString('card_number') ?? 'N/A');
      _cardSecurityCodeController = TextEditingController(text: prefs.getString('card_security_code') ?? 'N/A');
      _cardExpiryController = TextEditingController(text: prefs.getString('card_expiry') ?? 'N/A');
    });
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _emailController.text);
      await prefs.setString('card_name', _cardNameController.text);
      await prefs.setString('card_number', _cardNumberController.text);
      await prefs.setString('card_security_code', _cardSecurityCodeController.text);
      await prefs.setString('card_expiry', _cardExpiryController.text);

      final response = await http.post(
        Uri.parse('https://qr-based-mobile-wallet.onrender.com/update-profile'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': _username,
          'email': _emailController.text,
          'cardName': _cardNameController.text,
          'cardNumber': _cardNumberController.text,
          'cardSecurityCode': _cardSecurityCodeController.text,
          'cardExpiry': _cardExpiryController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile Updated Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back to the ProfilePage
      } else {
        // Log and show detailed error message
        print('Failed to update profile: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: ${response.body}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF564FA1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Email', _emailController),
                _buildTextField('Card Name', _cardNameController),
                _buildTextField('Card Number', _cardNumberController),
                _buildTextField('Card Security Code', _cardSecurityCodeController),
                _buildTextField('Card Expiry', _cardExpiryController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveUserData,
                  style: ElevatedButton.styleFrom(primary: Color(0xFF564FA1)),
                  child: Text('Save Changes', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
