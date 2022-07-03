import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'models/coin.dart';

class HttpException implements Exception {}

class HttpRequestFailure implements Exception {
  const HttpRequestFailure(this.statusCode);

  final int statusCode;
}

class JsonDecodeException implements Exception {}

class JsonDeserializationException implements Exception {}

class SpaceXApiClient {
  SpaceXApiClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  @visibleForTesting
  static const authority = 'api.coingecko.com';

  final http.Client _httpClient;

  Future<List<Coin>> fetchAllCoinList() async {
    final uri = Uri.https(authority, '/api/v3/coins/list');
    final response = await _get(uri);

    try {
      return response.map((dynamic coinJson) => Coin.fromJson(coinJson as Map<String, dynamic>)).toList();
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
