import 'package:flutter_test/flutter_test.dart';
import 'package:mx_share_api/src/models/crypto.dart';

void main() {
  group('Crypto Model', () {
    test(
      'supports value comparison',
      () {
        expect(
          const Crypto(
            id: '1',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
            currentPrice: 2999.0,
            symbol: 'BTC',
            name: 'Bitcoin',
          ),
          const Crypto(
            id: '1',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
            currentPrice: 2999.0,
            symbol: 'BTC',
            name: 'Bitcoin',
          ),
        );
      },
    );

    test(
      'has concise toString',
      () {
        expect(
          const Crypto(
            id: '1',
            symbol: 'BTC',
            name: 'Bitcoin',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
            currentPrice: 2999.0,
          ).toString(),
          equals('Crypto (1, Bitcoin, 2999.0)'),
        );
      },
    );

    test(
      'overrides stringify',
      () {
        expect(
          const Crypto(
            id: '1',
            symbol: 'BTC',
            name: 'Bitcoin',
            image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
            currentPrice: 2999.0,
          ).stringify,
          isTrue,
        );
      },
    );
  });
}
