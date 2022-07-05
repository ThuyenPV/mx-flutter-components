import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mx_share_api/mx_share_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late Uri mxCryptoUri;
  const queryParameters = <String, dynamic>{
    'vs_currency': 'usd',
    'order': 'market_cap_desc',
    'per_page': '10',
    'page': '1',
    'sparkline': 'false',
  };

  group('MxShareApi', () {
    late http.Client httpClient;
    late MxShareApiClient subject;

    final cryptoList = List.generate(
      3,
      (index) => Crypto(
        id: '$index',
        name: 'mock-crypto-name-$index',
        symbol: 'mock-crypto-symbol-$index',
        image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
        currentPrice: 1999.0,
      ),
    );

    setUp(() {
      httpClient = MockHttpClient();
      subject = MxShareApiClient(httpClient: httpClient);
      mxCryptoUri = Uri.https(MxShareApiClient.authority, '/api/v3/coins/markets', queryParameters);
    });

    test('constructor returns normally', () {
      expect(() => MxShareApiClient(), returnsNormally);
    });

    group('.fetchAllCoins', () {
      setUp(() {
        when(() => httpClient.get(mxCryptoUri)).thenAnswer(
          (invocation) async => http.Response(json.encode(cryptoList), 200),
        );
      });

      test('Throw HttpException when http client throws exception', () {
        when(() => httpClient.get(mxCryptoUri)).thenThrow(Exception());
        expect(
          () => subject.fetchAllCoins(queryParameters),
          throwsA(isA<HttpException>()),
        );
      });

      test('Throws HttpRequestFailure when response status code is not 200', () {
        when(() => httpClient.get(mxCryptoUri)).thenAnswer(
          (invocation) async => http.Response('', 400),
        );

        expect(
          () => subject.fetchAllCoins(queryParameters),
          throwsA(
            isA<HttpRequestFailure>().having((error) => error.statusCode, 'statusCode', 400),
          ),
        );
      });

      test('Throws JsonDecodeException when decoding response fails', () {
        when(() => httpClient.get(mxCryptoUri)).thenAnswer(
          (invocation) async => http.Response('definitely not json!', 200),
        );

        expect(
          () => subject.fetchAllCoins(queryParameters),
          throwsA(isA<JsonDecodeException>()),
        );
      });

      test('Throws JsonDeserializationException when deserializing json body fails', () {
        when(() => httpClient.get(mxCryptoUri)).thenAnswer(
          (invocation) async => http.Response('[{"this_is_not_a_crypto_response": true}]', 200),
        );

        expect(
          () => subject.fetchAllCoins(queryParameters).then((response) {
            return response.map((cryptoJson) {
              return Crypto.fromJson(cryptoJson as Map<String, dynamic>);
            }).toList();
          }),
          throwsA(isA<JsonDeserializationException>()),
        );
      });

      test('makes correct request', () async {
        await subject.fetchAllCoins(queryParameters);
        verify(() => httpClient.get(mxCryptoUri)).called(1);
      });

      test('returns correct list of crypto', () {
        expect(
          subject.fetchAllCoins(queryParameters),
          completion(equals(cryptoList)),
        );
      });
    });
  });
}
