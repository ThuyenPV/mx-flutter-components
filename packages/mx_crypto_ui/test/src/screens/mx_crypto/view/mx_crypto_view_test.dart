import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_cubit.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/mx_crypto_screen.dart';
import 'package:mx_share_api/mx_share_api.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_material_app.dart';
import '../../../helpers/test_navigator_observer.dart';
import '../../../helpers/test_navigator_screen.dart';

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

  group('Testcases for mx crypto view', () {
    late MxCryptoRepository mxCryptoRepository;

    setUp(() {
      mxCryptoRepository = MockMxCryptoRepository();
      when(() => mxCryptoRepository.fetchAllCoins(queryParameters)).thenAnswer(
        (invocation) async => cryptoList,
      );
    });
  });

  test('has MxCryptoScreen route', () {
    expect(
      MaterialPageRoute(builder: (context) => const MxCryptoScreen()),
      isA<MaterialPageRoute<void>>(),
    );
  });

  test('has MxCryptoDetailScreen route', () {
    expect(
      MaterialPageRoute(builder: (context) => const MxCryptoDetailScreen()),
      isA<MaterialPageRoute<void>>(),
    );
  });

  group('Testcases for mx crypto screen', () {
    late MxCryptoCubit mxCryptoCubit;
    late MockNavigator navigator;
    late TestNavigatorObserver _navObserver;

    setUp(() {
      _navObserver = TestNavigatorObserver();
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

    testWidgets('navigates to MxCryptoDetailScreen when crypto item is tapped', (tester) async {
      ///  given
      when(() => mxCryptoCubit.state).thenReturn(MxCryptoState(
        status: CryptoStatus.success,
        cryptoList: cryptoList,
      ));

      await mockNetworkImages(() async {
        await tester.pumpApp(
          BlocProvider.value(
            value: mxCryptoCubit,
            child: TestMaterialApp(
              home: const MxCryptoView(),
              navigatorObserver: _navObserver,
            ),
          ),
          navigator: navigator,
        );
      });

      ///  when
      var actualArgs;
      var isPushed = false;
      _navObserver.attachPushRouteObserverWithArgs('MX_CRYPTO_DETAIL_SCREEN', (args) {
        isPushed = true;
        actualArgs = args;
        return () {};
      });

      await tester.pumpAndSettle();

      final cryptoSuccessFinder = find.byKey(const ValueKey('crypto-list-is-success'));
      expect(cryptoSuccessFinder, findsOneWidget);

      final secondCryptoName = find.text(cryptoList.first.name, skipOffstage: false);
      expect(secondCryptoName, findsOneWidget);

      await tester.tap(secondCryptoName, warnIfMissed: false);
      await tester.pumpAndSettle();

      ///  then
      expect(isPushed, true);
      expect(actualArgs.name, 'mock-crypto-name-0');
      // verify(() => navigator.push(any(that: isRoute<void>()))).called(1);
    });

    testWidgets(
      'show loading when execute load data from API',
      (tester) async {
        when(() => mxCryptoCubit.state).thenReturn(const MxCryptoState(
          status: CryptoStatus.loading,
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

        final loadingFinder = find.byKey(
          const ValueKey('crypto-view-loading-status'),
        );
        expect(loadingFinder, findsOneWidget);
      },
    );

    testWidgets(
      'show error when call api is failure 2',
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
      'show error when call api is failure 1',
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
        await tester.pumpAndSettle();
        await navigator.pushNamed('MX_CRYPTO_DETAIL_SCREEN', arguments: cryptoList.first);
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'show empty message when list crypto response is empty',
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
