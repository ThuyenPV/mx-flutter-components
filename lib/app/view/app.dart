import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_flutter_components/config/app_router.dart';
import 'package:mx_flutter_components/dashboard/view/dashboard_screen.dart';
import 'package:mx_flutter_components/l10n/l10n.dart';
import 'package:mx_flutter_components/utils/page_route_util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRouter.allRouter(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case DashboardScreen.route:
            return PageRouteUtil.slideRouteBuilder(settings, MxCryptoScreen(key: ValueKey('mx-crypto-screen'),));
          case MxCryptoScreen.route:
            return PageRouteUtil.slideRouteBuilder(settings, MxCryptoDetailScreen());
          case MxCryptoDetailScreen.route:
            return PageRouteUtil.slideRouteBuilder(settings, DashboardScreen());
          default:
            return MaterialPageRoute(builder: (_) => UnknownPage());
        }
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DashboardScreen(),
    );
  }
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page not found!'),
      ),
    );
  }
}
