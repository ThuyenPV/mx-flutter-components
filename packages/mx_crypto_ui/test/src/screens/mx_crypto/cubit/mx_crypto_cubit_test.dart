import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_cubit.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';
import 'package:mx_share_api/mx_share_api.dart';

class MockMxCryptoRepository extends Mock implements MxCryptoRepository {}

void main() {
  group("MxCryptoCubit Test Case", () {
    late MxCryptoRepository mxCryptoRepository;

    Map<String, dynamic>? queryParameters = {
      'vs_currency': 'usd',
      'order': 'market_cap_desc',
      'per_page': '10',
      'page': '1',
      'sparkline': 'false',
    };

    final cryptoList = List.generate(
      3,
      (index) => Crypto(
        id: '$index',
        name: 'mock-crypto-name-$index',
        symbol: 'mock-crypto-symbol-$index',
        image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
        currentPrice: 1999.0,
      ),
    );

    setUp(() {
      mxCryptoRepository = MockMxCryptoRepository();
      when(() => mxCryptoRepository.fetchAllCoins(queryParameters)).thenAnswer((invocation) async => cryptoList);
    });

    test(
      'initial state is correct',
      () => {
        expect(
          MxCryptoCubit(cryptoRepository: mxCryptoRepository).state,
          equals(const MxCryptoState()),
        )
      },
    );

    blocTest<MxCryptoCubit, MxCryptoState>(
      'emits successful state with list crypto value',
      act: (cubit) => cubit.fetchCryptoList(queryParameters),
      build: () => MxCryptoCubit(
        cryptoRepository: mxCryptoRepository,
      ),
      expect: () => [
        const MxCryptoState(status: CryptoStatus.loading),
        MxCryptoState(
          status: CryptoStatus.success,
          cryptoList: cryptoList,
        ),
      ],
    );

    blocTest<MxCryptoCubit, MxCryptoState>(
      'emits failure state when repository throws exception',
      build: () {
        when(() => mxCryptoRepository.fetchAllCoins(queryParameters)).thenThrow(Exception());
        return MxCryptoCubit(cryptoRepository: mxCryptoRepository);
      },
      act: (cubit) => cubit.fetchCryptoList(queryParameters),
      expect: () => [
        const MxCryptoState(status: CryptoStatus.loading),
        const MxCryptoState(status: CryptoStatus.failure),
      ],
    );
  });
}
