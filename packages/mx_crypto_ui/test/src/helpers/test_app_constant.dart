import 'package:mx_share_api/mx_share_api.dart';

class TestAppConstant {
  static List<Crypto> get listCrypto {
    return List.generate(
      3,
      (index) => Crypto(
        id: '$index',
        name: 'mock-crypto-name-$index',
        symbol: 'mock-crypto-symbol-$index',
        image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
        currentPrice: 1999.0,
      ),
    );
  }

  static Map<String, dynamic>? queryParameters = {
    'vs_currency': 'usd',
    'order': 'market_cap_desc',
    'per_page': '10',
    'page': '1',
    'sparkline': 'false',
  };
}
