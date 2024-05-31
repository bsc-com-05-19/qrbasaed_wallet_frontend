import 'package:flutter/cupertino.dart';
import 'package:qrbased_frontend/home.dart';
import 'package:qrbased_frontend/welcome.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  HomePage.routeName: (context) => const HomePage()
};
