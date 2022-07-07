import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_cubit.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto_detail/mx_crypto_detail_screen.dart';
import 'package:mx_share_api/mx_share_api.dart';

/// {@template crypto_list}
/// A Dart class that exposes implement Crypto List UI
/// {@contemplate}
class CryptoList extends StatefulWidget {
  /// {@macro crypto_list}
  const CryptoList({super.key});

  @override
  State<CryptoList> createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  Map<String, dynamic>? queryParameters = {
    'vs_currency': 'usd',
    'order': 'market_cap_desc',
    'per_page': '10',
    'page': '1',
    'sparkline': 'false',
  };

  Future<void> fetchCryptoList() async {
    return context.read<MxCryptoCubit>().fetchCrypto(queryParameters);
  }

  @override
  void initState() {
    fetchCryptoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MxCryptoCubit, MxCryptoState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchCryptoStatus.initial:
            return StatusView(
              key: ValueKey('crypto-view-initial-status'),
              FetchCryptoStatus.initial,
            );
          case FetchCryptoStatus.loading:
            return const LoadingWidget(
              key: ValueKey('fetch-status-is-loading'),
            );
          case FetchCryptoStatus.success:
            final cryptoList = state.cryptoList ?? [];
            if (cryptoList.isEmpty) {
              return const StatusView(
                FetchCryptoStatus.failure,
                key: ValueKey('data-response-is-empty-key'),
              );
            }
            return Expanded(
              key: const ValueKey('fetch-status-is-success-key'),
              child: ListView.separated(
                key: const ValueKey('ListView.separated'),
                itemCount: cryptoList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => CryptoItem(
                  crypto: cryptoList[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MxCryptoDetailScreen.route,
                      arguments: cryptoList[index],
                    );
                  },
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            );
          case FetchCryptoStatus.failure:
          default:
            return const StatusView(
              FetchCryptoStatus.failure,
              key: ValueKey('fetch-status-is-failure-key'),
            );
        }
      },
    );
  }
}

/// {@template crypto_item}
/// A Dart class that exposes implement Crypto Item UI
/// {@contemplate}
class CryptoItem extends StatelessWidget {
  /// {@macro crypto_item}
  const CryptoItem({
    super.key,
    required this.crypto,
    required this.onTap,
  });

  /// The crypto model to display for each crypto_item
  final Crypto crypto;

  /// Event when use click into crypto_item
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 70,
          alignment: Alignment.center,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(crypto.image),
              backgroundColor: Colors.grey.withOpacity(0.25),
            ),
            trailing: Text('${crypto.currentPrice}'),
            title: Text(crypto.name),
            subtitle: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(crypto.symbol.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}

/// {@template loading_widget}
/// A Dart class that exposes implement circle loading when call load 10 crypto
/// {@contemplate}
class LoadingWidget extends StatelessWidget {
  /// {@macro loading_widget}
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.blue.withOpacity(0.25),
        ),
      ),
    );
  }
}

/// {@template status_view}
/// A Dart class that exposes when status returns data isEmpty, isFailure, isInitial
/// {@contemplate}
class StatusView extends StatelessWidget {
  /// {@macro status_view}
  const StatusView(
    this.status, {
    super.key,
  });

  final FetchCryptoStatus status;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(status.toString()),
      ),
    );
  }
}
