import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color(0xFF564FA1),
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFF564FA1),
                ),
              ),
            ],
          ),
          const Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: [
                  _buildSectionHeader('Account Settings'),
                  _buildSettingsTile(Icons.person, 'Profile', 'Edit your profile'),
                  _buildSettingsTile(Icons.lock, 'Change Password', 'Change your password'),
                  _buildSettingsTile(Icons.email, 'Email', 'Change your email'),

                  _buildSectionHeader('Notification Settings'),
                  _buildSettingsTile(Icons.notifications, 'Push Notifications', 'Manage push notifications'),
                  _buildSettingsTile(Icons.email, 'Email Notifications', 'Manage email notifications'),

                  _buildSectionHeader('Privacy Settings'),
                  _buildSettingsTile(Icons.security, 'Security', 'Manage security settings'),
                  _buildSettingsTile(Icons.privacy_tip, 'Privacy', 'Manage privacy settings'),

                  _buildSectionHeader('Other Settings'),
                  _buildSettingsTile(Icons.info, 'About', 'About this app'),
                  _buildSettingsTile(Icons.logout, 'Log Out', 'Log out of your account'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 16,),
      onTap: () {
        // Handle settings option tap
      },
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: const Center(
        child: Text('Second Screen Content'),
      ),
    );
  }
}


