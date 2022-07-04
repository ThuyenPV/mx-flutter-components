// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_repository/src/mx_crypto_repository.dart';

void main() {
  group('MxCoinRepository', () {
    test('can be instantiated', () {
      expect(MxCryptoRepository(), isNotNull);
    });
  });
}
