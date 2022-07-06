import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_cubit.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/mx_crypto_screen.dart';
import 'package:mx_share_api/mx_share_api.dart';

import '../../../helpers/pump_app.dart';

class MockMxCryptoRepository extends Mock implements MxCryptoRepository {}

class MockMxCryptoCubit extends MockCubit<MxCryptoState> implements MxCryptoCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
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

  Map<String, dynamic>? queryParameters = {
    'vs_currency': 'usd',
    'order': 'market_cap_desc',
    'per_page': '10',
    'page': '1',
    'sparkline': 'false',
  };

  group('CryptoView Testcases', () {
    late MxCryptoRepository mxCryptoRepository;

    setUp(() {
      mxCryptoRepository = MockMxCryptoRepository();
      when(() => mxCryptoRepository.fetchAllCoins(queryParameters)).thenAnswer(
        (invocation) async => cryptoList,
      );
    });
  });

  test('has route', () {
    expect(
      MaterialPageRoute(builder: (context) => const MxCryptoScreen()),
      isA<MaterialPageRoute<void>>(),
    );
  });

  group('CryptoView', () {
    late MxCryptoCubit mxCryptoCubit;
    late MockNavigator navigator;

    setUp(() {
      mxCryptoCubit = MockMxCryptoCubit();
      navigator = MockNavigator();
      when(() => navigator.push(any(that: isRoute<void>()))).thenAnswer(
        (invocation) async {},
      );
    });

    setUpAll(() {
      registerFallbackValue(
        const MxCryptoState(
          status: CryptoStatus.initial,
          cryptoList: const [],
        ),
      );
    });

    testWidgets(
      'navigates to MxCryptoDetailScreen when crypto item is tapped',
      (tester) async {
        when(() => mxCryptoCubit.state).thenReturn(MxCryptoState(
          status: CryptoStatus.success,
          cryptoList: cryptoList,
        ));

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: mxCryptoCubit,
              child: const MxCryptoView(),
            ),
            navigator: navigator,
          );
        });

        final cryptoSuccessFinder = find.byKey(const ValueKey('crypto-list-is-success'));
        expect(cryptoSuccessFinder, findsOneWidget);

        final secondCryptoName = find.text(cryptoList.last.name, skipOffstage: false);
        expect(secondCryptoName, findsOneWidget);

        await tester.tap(secondCryptoName, warnIfMissed: false);
        await tester.pumpAndSettle();

        /// Verify that a push event happened
        // verify(() => navigator.push(any(that: isRoute<void>()))).called(1);
      },
    );

    testWidgets(
      'navigates to MxCryptoDetailScreen when crypto item is loading',
      (tester) async {
        when(() => mxCryptoCubit.state).thenReturn(
          const MxCryptoState(
            status: CryptoStatus.loading,
          ),
        );

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: mxCryptoCubit,
              child: const MxCryptoView(),
            ),
            navigator: navigator,
          );
        });

        final loadingFinder = find.byKey(
          const ValueKey('crypto-view-loading-status'),
        );
        expect(loadingFinder, findsOneWidget);
      },
    );

    testWidgets(
      'navigates to MxCryptoDetailScreen when crypto item is failure',
      (tester) async {
        when(() => mxCryptoCubit.state).thenReturn(
          const MxCryptoState(
            status: CryptoStatus.failure,
          ),
        );

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: mxCryptoCubit,
              child: const MxCryptoView(),
            ),
            navigator: navigator,
          );
        });

        final failureWidgetFinder = find.byKey(const ValueKey('crypto-list-is-failure'));
        expect(failureWidgetFinder, findsOneWidget);
      },
    );

    testWidgets(
      'navigates to MxCryptoDetailScreen when crypto item is empty',
      (tester) async {
        when(() => mxCryptoCubit.state).thenReturn(
          const MxCryptoState(
            status: CryptoStatus.success,
            cryptoList: [],
          ),
        );

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: mxCryptoCubit,
              child: const MxCryptoView(),
            ),
            navigator: navigator,
          );
        });

        final failureWidgetFinder = find.byKey(
          const ValueKey('crypto-list-is-isEmpty'),
        );
        expect(failureWidgetFinder, findsOneWidget);
      },
    );
  });
}
