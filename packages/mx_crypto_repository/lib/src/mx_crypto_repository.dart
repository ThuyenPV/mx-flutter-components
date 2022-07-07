import 'package:mx_share_api/mx_share_api.dart';

/// Thrown when an error occurs while looking up rockets.
class CryptoListException implements Exception {}

/// Thrown when an error occurs while performing a search.
class SearchException implements Exception {}

/// {@template mx_coin_repository}
/// A Dart class that exposes methods to call mx_share_api layer
/// {@contemplate}
class MxCryptoRepository {
  /// {@macro mx_coin_repository}
  MxCryptoRepository({
    MxShareApiClient? mxShareApiClient,
  }) : mxShareApiClient = mxShareApiClient ?? MxShareApiClient();

  final MxShareApiClient mxShareApiClient;

  /// Returns a list of all coin list from coingecko API
  ///
  /// Throws a [CryptoListException] if an error occurs.
  Future<List<Crypto>> fetchCrypto(Map<String, dynamic>? queryParameters) async {
    try {
      final cryptoList = await mxShareApiClient.fetchCrypto(queryParameters);
      return cryptoList;
    } on Exception {
      throw CryptoListException();
    }
  }
}
