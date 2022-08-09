import 'package:flutter/material.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_flutter_components/dashboard/view/dashboard_screen.dart';

class AppRouter {
  static const DASHBOARD_SCREEN_ROUTE = DashboardScreen.route;
  static const MX_CRYPTO_SCREEN_ROUTE = MxCryptoScreen.route;
  static const MX_CRYPTO_DETAIL_SCREEN_ROUTE = MxCryptoDetailScreen.route;

  static Map<String, Widget Function(BuildContext)> allRouter() {
    return {
      DASHBOARD_SCREEN_ROUTE: (context) => const DashboardScreen(),
      MX_CRYPTO_SCREEN_ROUTE: (context) => const MxCryptoScreen(),
      MX_CRYPTO_DETAIL_SCREEN_ROUTE: (context) => const MxCryptoDetailScreen(),
    };
  }
}
