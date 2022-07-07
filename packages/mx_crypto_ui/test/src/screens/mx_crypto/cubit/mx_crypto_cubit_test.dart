import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_cubit.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';

import '../../../helpers/test_app_constant.dart';

class MockMxCryptoRepository extends Mock implements MxCryptoRepository {}

void main() {
  group('Testcases for mx crypto cubit module', () {
    late MxCryptoRepository mxCryptoRepository;

    final queryParam = TestAppConstant.queryParameters;
    final cryptoList = TestAppConstant.listCrypto;

    setUp(() {
      mxCryptoRepository = MockMxCryptoRepository();
      when(() => mxCryptoRepository.fetchCrypto(queryParam)).thenAnswer((invocation) async => cryptoList);
    });

    test(
      'Initial state is correct',
      () => {
        expect(
          MxCryptoCubit(cryptoRepository: mxCryptoRepository).state,
          equals(const MxCryptoState()),
        )
      },
    );

    blocTest<MxCryptoCubit, MxCryptoState>(
      'Emits successful state with list crypto value',
      act: (cubit) => cubit.fetchCrypto(queryParam),
      build: () => MxCryptoCubit(
        cryptoRepository: mxCryptoRepository,
      ),
      expect: () => [
        const MxCryptoState(status: FetchCryptoStatus.loading),
        MxCryptoState(
          status: FetchCryptoStatus.success,
          cryptoList: cryptoList,
        ),
      ],
    );

    blocTest<MxCryptoCubit, MxCryptoState>(
      'Emits failure state when repository throws exception',
      build: () {
        when(() => mxCryptoRepository.fetchCrypto(queryParam)).thenThrow(Exception());
        return MxCryptoCubit(cryptoRepository: mxCryptoRepository);
      },
      act: (cubit) => cubit.fetchCrypto(queryParam),
      expect: () => [
        const MxCryptoState(status: FetchCryptoStatus.loading),
        const MxCryptoState(status: FetchCryptoStatus.failure),
      ],
    );
  });
}
