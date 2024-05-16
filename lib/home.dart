import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat.yMd().format(DateTime.now());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.2,
        decoration: const BoxDecoration(
          color: Color(0xFF564FA1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 10,
            left: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    'izepay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
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
                      height: 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Francis Eneya',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Align to the left
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Container(
                    width: 178,
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color:  Color(0xFF7870B3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 0), // Adjust the width as needed
                        ElevatedButton(
                          onPressed: () {
                            // Add your button functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF564FA1), backgroundColor: Color(0xFFD4B150),
                            minimumSize: const Size(110, 34), 
                            padding: const EdgeInsets.symmetric(horizontal: 0), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Color(0xFFD4B150)),
                            ),
                          ),
                          child: const Text(
                            'Balance',
                            style: TextStyle(fontSize: 14),
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
    );
  }
}
