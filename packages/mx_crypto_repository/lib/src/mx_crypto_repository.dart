import 'package:mx_share_api/mx_share_api.dart';

/// Thrown when an error occurs while looking up rockets.
class CoinListException implements Exception {}

/// Thrown when an error occurs while performing a search.
class SearchException implements Exception {}

/// {@template mx_coin_repository}
/// A Dart class which exposes methods to implement coin-list-related
/// functionality.
/// {@endtemplate}
class MxCryptoRepository {
  /// {@macro mx_coin_repository}
  MxCryptoRepository({
    MxShareApiClient? mxShareApiClient,
  }) : mxShareApiClient = mxShareApiClient ?? MxShareApiClient();

  final MxShareApiClient mxShareApiClient;

  /// Returns a list of all coin list from coingecko API
  ///
  /// Throws a [CoinListException] if an error occurs.
  Future<List<Crypto>> fetchAllCoins(Map<String, dynamic>? queryParameters) async {
    try {
      final result = await mxShareApiClient.fetchAllCoins(queryParameters);
      return result;
    } on Exception {
      throw CoinListException();
    }
  }
}
