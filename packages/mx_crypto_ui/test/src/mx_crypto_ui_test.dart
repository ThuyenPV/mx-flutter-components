import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/mx_crypto_screen.dart';
import 'package:mx_share_api/mx_share_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_crypto_repository/src/mx_crypto_repository.dart';

class MockMxShareApiClient extends Mock implements MxShareApiClient {}

void main() {
  late MxShareApiClient mxShareApiClient;
  late MxCryptoRepository mxCryptoRepository;

  const queryParameters = <String, dynamic>{
    'vs_currency': 'usd',
    'order': 'market_cap_desc',
    'per_page': '10',
    'page': '1',
    'sparkline': 'false',
  };

  final cryptoList = List.generate(
    3,
    (index) => Crypto(
      id: '$index',
      symbol: 'btc',
      name: 'Bitcoin',
      image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
      currentPrice: 2999.0,
    ),
  );

  setUp(() {
    mxShareApiClient = MockMxShareApiClient();
    when(() => mxShareApiClient.fetchCrypto(queryParameters)).thenAnswer((_) async => cryptoList);
    mxCryptoRepository = MxCryptoRepository(mxShareApiClient: mxShareApiClient);
  });

  group('test', () {
    setUp(() {
      mxCryptoRepository = MxCryptoRepository();
      when(() => mxCryptoRepository.fetchCrypto(queryParameters)).thenAnswer((_) async => cryptoList);
    });

    test('has route', () {
      expect(MxCryptoScreen.route, isA<MaterialPageRoute<void>>());
    });
  });
}
