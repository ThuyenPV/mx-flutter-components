import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/mx_crypto_screen.dart';
import 'package:mx_share_api/mx_share_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_crypto_repository/src/mx_crypto_repository.dart';

import 'helpers/test_app_constant.dart';

class MockMxShareApiClient extends Mock implements MxShareApiClient {}

void main() {
  late MxShareApiClient mxShareApiClient;
  late MxCryptoRepository mxCryptoRepository;

  final queryParam = TestAppConstant.queryParameters;
  final cryptoList = TestAppConstant.listCrypto;

  setUp(() {
    mxShareApiClient = MockMxShareApiClient();
    when(() => mxShareApiClient.fetchCrypto(queryParam)).thenAnswer((_) async => cryptoList);
    mxCryptoRepository = MxCryptoRepository(mxShareApiClient: mxShareApiClient);
  });
}
