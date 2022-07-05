import 'package:flutter/material.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto_detail_screen.dart';
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
  final MxCryptoRepository _mxCoinRepository = MxCryptoRepository();
  final ValueNotifier<List<Crypto>> _coinsNotifier = ValueNotifier([]);

  Map<String, dynamic>? queryParameters = {
    'vs_currency': 'usd',
    'order': 'market_cap_desc',
    'per_page': '10',
    'page': '1',
    'sparkline': 'false',
  };

  void fetchAllCoinList() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _mxCoinRepository.fetchAllCoins(queryParameters).then((coins) {
        _coinsNotifier.value = coins;
      });
    });
  }

  @override
  void initState() {
    fetchAllCoinList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _coinsNotifier,
      builder: (BuildContext context, List<Crypto> coins, __) {
        if (coins.isEmpty) return const LoadingWidget();
        return Expanded(
          child: ListView.separated(
            itemCount: coins.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => CryptoItem(
              crypto: coins[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MxCryptoDetailScreen.route,
                  arguments: coins[index],
                );
              },
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        );
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
    return GestureDetector(
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
