// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_crypto_repository/src/mx_crypto_repository.dart';
import 'package:mx_share_api/mx_share_api.dart';

class MockMxShareApiClient extends Mock implements MxShareApiClient {}

const Map<String, dynamic> queryParameters = {
  'vs_currency': 'usd',
  'order': 'market_cap_desc',
  'per_page': '10',
  'page': '1',
  'sparkline': 'false',
};

void main() {
  group('MxCoinRepository', () {
    late MxShareApiClient mxShareApiClient;
    late MxCryptoRepository mxCryptoRepository;

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
      when(() => mxShareApiClient.fetchAllCoins(queryParameters)).thenAnswer((_) async => cryptoList);
      mxCryptoRepository = MxCryptoRepository(mxShareApiClient: mxShareApiClient);
    });

    test('Constructor return normally', () {
      expect(() => MxCryptoRepository(), returnsNormally);
    });

    group('.fetchAllCrypto', () {
      test('throws fetchAllCrypto when API throws an exception', () async {
        when(() => mxShareApiClient.fetchAllCoins(queryParameters)).thenThrow(HttpException());
        expect(() => mxCryptoRepository.fetchAllCoins(queryParameters), throwsA(isA<CryptoListException>()));
        verify(() => mxShareApiClient.fetchAllCoins(queryParameters)).called(1);
      });

      test('makes correct request', () async {
        await mxCryptoRepository.fetchAllCoins(queryParameters);
        verify(() => mxShareApiClient.fetchAllCoins(queryParameters)).called(1);
      });
    });
  });
}
