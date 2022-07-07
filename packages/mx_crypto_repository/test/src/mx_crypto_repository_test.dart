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
  group('Testcases for mx crypto repository package', () {
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
      when(() => mxShareApiClient.fetchCrypto(queryParameters)).thenAnswer((_) async => cryptoList);
      mxCryptoRepository = MxCryptoRepository(mxShareApiClient: mxShareApiClient);
    });

    test('crypto repository constructor return normally', () {
      expect(() => MxCryptoRepository(), returnsNormally);
    });

    group('Execute fetch crypto from API', () {
      /// given
      test('throws fetchAllCrypto when API throws an exception', () async {
        when(() => mxShareApiClient.fetchCrypto(queryParameters)).thenThrow(HttpException());
        expect(() => mxCryptoRepository.fetchCrypto(queryParameters), throwsA(isA<CryptoListException>()));
        verify(() => mxShareApiClient.fetchCrypto(queryParameters)).called(1);
      });

      test('execute api fetchAllCoins call once time', () async {
        await mxCryptoRepository.fetchCrypto(queryParameters);
        verify(() => mxShareApiClient.fetchCrypto(queryParameters)).called(1);
      });
    });
  });
}
