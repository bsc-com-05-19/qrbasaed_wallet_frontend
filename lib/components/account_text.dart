import 'package:flutter/material.dart';

import '../login.dart';


class AccountText extends StatelessWidget {
  const AccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 15, color: Colors.black54),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(fontSize: 15, color: Color(0xFF564FA1)),
          ),
        ),
      ],
    );
  }
}
