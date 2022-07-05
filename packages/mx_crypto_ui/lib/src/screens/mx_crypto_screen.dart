import 'package:flutter/material.dart';
import 'package:mx_crypto_ui/src/components/categories.dart';
import 'package:mx_crypto_ui/src/components/crypto_chart.dart';
import 'package:mx_crypto_ui/src/components/crypto_list.dart';

/// {@template mx_crypto_screen}
/// mx_crypto_screen to display all information about crypto & chart
/// {@endtemplate}
class MxCryptoScreen extends StatelessWidget {
  /// {@macro mx_crypto_screen}
  const MxCryptoScreen({Key? key}) : super(key: key);

  /// {@macro to navigator to mx_crypto_screen}
  static const route = 'MX_CRYPTO_SCREEN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            margin: const EdgeInsets.only(top: 12, left: 12),
            alignment: Alignment.bottomLeft,
            child: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.grey.withOpacity(0.25),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: const [
            Categories(),
            CryptoChart(title: 'CRYPTO CHART'),
            CryptoList(),
          ],
        ),
      ),
    );
  }
}
