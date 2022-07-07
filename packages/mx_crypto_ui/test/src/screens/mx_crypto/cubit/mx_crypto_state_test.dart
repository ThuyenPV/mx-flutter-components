import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';

void main() {
  group('CryptoState', () {
    test('supports value comparison', () {
      expect(
        const MxCryptoState(status: CryptoStatus.success, cryptoList: []),
        const MxCryptoState(status: CryptoStatus.success, cryptoList: []),
      );
    });
  });
}
