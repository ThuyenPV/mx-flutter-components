import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';

void main() {
  group('CryptoState', () {
    test('supports initial state comparison', () {
      expect(
        const MxCryptoState(status: CryptoStatus.initial, cryptoList: []),
        const MxCryptoState(status: CryptoStatus.initial, cryptoList: []),
      );
    });

    test('supports successful state comparison', () {
      expect(
        const MxCryptoState(status: CryptoStatus.success, cryptoList: []),
        const MxCryptoState(status: CryptoStatus.success, cryptoList: []),
      );
    });

    test('supports failure state comparison', () {
      expect(
        const MxCryptoState(status: CryptoStatus.failure, cryptoList: []),
        const MxCryptoState(status: CryptoStatus.failure, cryptoList: []),
      );
    });

    test('supports loading state comparison', () {
      expect(
        const MxCryptoState(status: CryptoStatus.loading, cryptoList: []),
        const MxCryptoState(status: CryptoStatus.loading, cryptoList: []),
      );
    });
  });
}
