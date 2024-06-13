import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrbased_frontend/home.dart';
import 'package:qrbased_frontend/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'components/account_text.dart';
import 'components/no_account_text.dart'; // Import JSON package


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var url = Uri.parse('https://qr-based-mobile-wallet.onrender.com/login');
      try {
        var response = await http.post(url, body: {'username': _username, 'password': _password});

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          var sessionId = data['sessionId'];
          var user = data['user'];

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('session_id', sessionId);
          await prefs.setString('username', user['username']);
          await prefs.setString('email', user['email']);
          await prefs.setString('client_id', user['clientId']);
          await prefs.setString('secret_key', user['secretKey']);
          await prefs.setString('card_name', user['card']['name']);
          await prefs.setString('card_number', user['card']['number']);
          await prefs.setString('card_security_code', user['card']['securityCode']);
          await prefs.setString('card_expiry', user['card']['expiry']);
          await prefs.setString('balance', user['balance']);

          print('Session ID stored: $sessionId');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          print('Login failed: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed: ${response.statusCode}'),
            ),
          );
        }
      } catch (e) {
        print('Error during login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred during login. Please try again.', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
            ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFF564FA1), // Replace deepPurple with the hex color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/izelogo.png', // Replace with your logo asset path
                        height: 50, // Adjust the height of the logo
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome To IZEpay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Divider(),// Adjust height for spacing
                    Center(
                      child: const Text(
                        'Sign in to get started',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Adjust height for spacing
                    TextFormField(
                      key: const Key("username_field"),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: "Enter your username",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Icon(
                          Icons.account_circle,
                          color: Color(0xFF564FA1), // Replace deepPurple with the hex color
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) => _username = value!,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      key: const Key("password_field"),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: "Enter your password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF564FA1), // Replace deepPurple with the hex color
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      key: const Key("login_button"),
                      onPressed: _loginUser,
                      child: const Text('Sign in'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF564FA1),
                        textStyle: TextStyle(fontSize: 16)
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Add navigation to sign in page here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        );
                      },
                      child: const NoAccountText(),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
