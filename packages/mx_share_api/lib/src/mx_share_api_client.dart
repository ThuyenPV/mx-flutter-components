import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:mx_share_api/src/models/crypto.dart';

/// Thrown if an exception occurs while making an `http` request.
class HttpException implements Exception {}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@contemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// Thrown when an error occurs while decoding the response body.
class JsonDecodeException implements Exception {}

/// Thrown when an error occurs while deserializing the response body.
class JsonDeserializationException implements Exception {}

/// {@template mx_share_api_client}
/// A Dart API Client for the Coingecko REST API.
/// Learn more at https://api.coingecko.com/api/v3
/// {@contemplate}
class MxShareApiClient {
  /// {@macro spacex_api_client}
  MxShareApiClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// The host URL used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  static const authority = 'api.coingecko.com';

  final http.Client _httpClient;

  /// Fetches all coin list from coingecko API.
  ///
  /// REST call: `GET /api/v3/coins/markets`
  Future<List<Crypto>> fetchAllCoins(Map<String, dynamic>? queryParameters) async {
    final uri = Uri.https(authority, '/api/v3/coins/markets', queryParameters);
    final response = await _get(uri);
    try {
      final cryptoList = response.map((cryptoJson) {
        return Crypto.fromJson(cryptoJson as Map<String, dynamic>);
      }).toList();

      return cryptoList;
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  Future<List<dynamic>> _get(Uri uri) async {
    http.Response response;

    try {
      response = await _httpClient.get(uri);
    } catch (_) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    try {
      return json.decode(response.body) as List;
    } catch (_) {
      throw JsonDecodeException();
    }
  }
}
