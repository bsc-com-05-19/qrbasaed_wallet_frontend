import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const double topPadding = 10;
  static const double bottomPadding = 50;

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
            top: topPadding,
            bottom: bottomPadding,
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
                      fontWeight: FontWeight.bold,
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
                  const SizedBox(width: 8,),
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
            ],
          ),
        ),
      ),
    );
  }
}
