// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';

void main() {
  group('MxCryptoUi', () {
    test('can be MxCryptoScreen instantiated', () {
      expect(MxCryptoScreen(), isNotNull);
    });

    test('can be MxCryptoDetailScreen instantiated', () {
      expect(MxCryptoDetailScreen(), isNotNull);
    });
  });
}
