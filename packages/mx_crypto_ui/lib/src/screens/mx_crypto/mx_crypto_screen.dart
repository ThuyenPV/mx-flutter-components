import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/src/components/crypto_chart.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_cubit.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/view/categories.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/view/crypto_list.dart';

/// {@template mx_crypto}
/// mx_crypto to display all information about crypto & chart
/// {@endtemplate}
class MxCryptoScreen extends StatelessWidget {
  /// {@macro mx_crypto}
  const MxCryptoScreen({super.key});

  /// {@macro to navigator to mx_crypto}
  static const route = 'MX_CRYPTO_SCREEN';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MxCryptoCubit(cryptoRepository: MxCryptoRepository()),
      child: const MxCryptoView(),
    );
  }
}

class MxCryptoView extends StatelessWidget {
  const MxCryptoView({super.key});

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
            CryptoList(
              key: ValueKey('crypto-screen-list'),
            ),
          ],
        ),
      ),
    );
  }
}
