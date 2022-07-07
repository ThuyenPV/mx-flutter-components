import 'package:flutter/material.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_flutter_components/dashboard/view/dashboard_screen.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> allRouter() {
    return {
      DashboardScreen.route: (context) => DashboardScreen(),
      MxCryptoScreen.route: (context) => MxCryptoScreen(key: ValueKey('MxCryptoScreen'),),
      MxCryptoDetailScreen.route: (context) => MxCryptoDetailScreen(),
    };
  }
}
