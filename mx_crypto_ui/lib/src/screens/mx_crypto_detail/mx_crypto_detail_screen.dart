import 'package:flutter/material.dart';
import 'package:mx_crypto_ui/src/components/crypto_chart.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto_detail/view/crypto_detail_list.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto_detail/view/header.dart';
import 'package:mx_share_api/mx_share_api.dart';

/// {@template mx_crypto_detail}
/// mx_crypto_detail to display all detail crypto information
/// {@endtemplate}
class MxCryptoDetailScreen extends StatelessWidget {
  /// {@macro mx_crypto_detail}
  const MxCryptoDetailScreen({super.key});

  /// {@macro to navigator to mx_crypto_detail screen}
  static const route = 'MX_CRYPTO_DETAIL_SCREEN';

  @override
  Widget build(BuildContext context) {
    Crypto? args;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      args = ModalRoute.of(context)!.settings.arguments as Crypto;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            key: ValueKey('avatar-key-2'),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 12, left: 12),
              alignment: Alignment.bottomLeft,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.blue.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Header(
              key: ValueKey('header-key'),
              crypto: args,
            ),
            const CryptoChart(title: 'CRYPTO DETAIL CHART'),
            const CryptoDetailList(),
          ],
        ),
      ),
    );
  }
}
