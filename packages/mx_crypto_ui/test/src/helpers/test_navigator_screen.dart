import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class NavigatorScreen extends StatefulWidget {
  String targetRouteName;
  Object arguments;

  NavigatorScreen({
    required this.targetRouteName,
    required this.arguments,
  });

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      Navigator.pushNamed(context, widget.targetRouteName, arguments: widget.arguments);
    });
    return Container();
  }
}

class FakeMyApp extends StatelessWidget {
  Widget homeScreen;
  Widget targetScreen;

  FakeMyApp({
    required this.homeScreen,
    required this.targetScreen,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => homeScreen,
        "MX_CRYPTO_DETAIL_SCREEN": (_) => targetScreen,
      },
    );
  }
}
