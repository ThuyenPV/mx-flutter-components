import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/mx_crypto_screen.dart';

import 'test_navigator_observer.dart';

class TestMaterialApp extends StatelessWidget {
  TestMaterialApp({
    required this.home,
    required this.navigatorObserver,
  });

  final Widget home;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Screen',
      home: home,
      navigatorObservers: [navigatorObserver ?? TestNavigatorObserver()],
      routes: {
        MxCryptoScreen.route: (context) => DummyTestRoute(routeName: MxCryptoScreen.route),
      },
    );
  }
}

class DummyTestRoute extends StatelessWidget {
  DummyTestRoute({
    Key? key,
    required this.routeName,
  }) : super(key: key ?? Key(routeName));

  final String routeName;

  @override
  Widget build(BuildContext context) => Text(routeName);
}
