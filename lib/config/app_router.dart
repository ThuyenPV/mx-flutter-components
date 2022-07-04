import 'package:flutter/material.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_flutter_components/home/view/home_screen.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> allRouter() {
    return {
      HomeScreen.route: (context) => HomeScreen(),
      MxCryptoScreen.route: (context) => MxCryptoScreen(),
      MxCryptoDetailScreen.route: (context) => MxCryptoDetailScreen(),
    };
  }
}
