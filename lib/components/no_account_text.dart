import 'package:flutter/material.dart';

import '../login.dart';
import '../sign_up.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 15, color: Colors.black54),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignupPage(),
            ),
          ),
          child: const Text(
            "Create Account",
            style: TextStyle(fontSize: 15, color: Color(0xFF564FA1)),
          ),
        ),
      ],
    );
  }
}
