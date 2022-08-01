import 'package:flutter/material.dart';

import 'test_navigator_observer.dart';

class TestMaterialApp extends StatelessWidget {
  final Widget home;
  final NavigatorObserver? navigatorObserver;

  TestMaterialApp({
    Key? key,
    required this.home,
    required this.navigatorObserver,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Screen',
      home: home,
      navigatorObservers: [navigatorObserver ?? TestNavigatorObserver()],
      routes: {
        'MX_CRYPTO_DETAIL_SCREEN': (context) => _baseRoute('MX_CRYPTO_DETAIL_SCREEN'),
      },
    );
  }

  Widget _baseRoute(String routeName) => DummyTestRoute(routeName: routeName);
}

class DummyTestRoute extends StatelessWidget {
  final String routeName;

  DummyTestRoute({
    Key? key,
    required this.routeName,
  }) : super(key: key ?? Key(routeName));

  @override
  Widget build(BuildContext context) => Text(routeName);
}
