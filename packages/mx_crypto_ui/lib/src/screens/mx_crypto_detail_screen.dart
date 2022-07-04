import 'package:flutter/material.dart';
import 'package:mx_crypto_ui/src/screens/components/coin_list.dart';
import 'package:mx_crypto_ui/src/screens/components/crypto_chart.dart';
import 'package:mx_crypto_ui/src/screens/components/header.dart';

/// {@template mx_crypto_detail_screen}
/// mx_crypto_detail_screen to display all detail crypto information
/// {@endtemplate}
class MxCryptoDetailScreen extends StatelessWidget {
  /// {@macro mx_crypto_detail_screen}
  const MxCryptoDetailScreen({Key? key}) : super(key: key);

  /// {@macro to navigator to mx_crypto_detail_screen screen}
  static const route = 'MX_CRYPTO_DETAIL_SCREEN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 12, left: 12),
              alignment: Alignment.bottomLeft,
              child: const CircleAvatar(
                radius: 90,
                backgroundColor: Colors.lightBlue,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Header(),
            CryptoChart(
              onTap: () {
                Navigator.pushNamed(context, MxCryptoDetailScreen.route);
              },
            ),
            const CoinList(),
          ],
        ),
      ),
    );
  }
}
