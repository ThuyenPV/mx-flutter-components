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

  group('CryptoView Testcases', () {
    late MxCryptoRepository mxCryptoRepository;

    setUp(() {
      mxCryptoRepository = MockMxCryptoRepository();
      when(() => mxCryptoRepository.fetchAllCoins(queryParameters)).thenAnswer(
        (invocation) async => cryptoList,
      );
    });
  });

  test('has MxCryptoDetailScreen route', () {
    expect(
      MaterialPageRoute(builder: (context) => const MxCryptoDetailScreen()),
      isA<MaterialPageRoute<void>>(),
    );
  });

  group('Testcases for mx crypto view', () {
    late MxCryptoRepository mxCryptoRepository;

    setUp(() {
      mxCryptoRepository = MockMxCryptoRepository();
      when(() => mxCryptoRepository.fetchAllCoins(queryParameters)).thenAnswer(
        (invocation) async => cryptoList,
      );
    });
  });

  group('CryptoView', () {
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
          cryptoList: [],
        ),
      );
    });

    group('Test.... ', () {
      late MxCryptoRepository repository;

      setUp(() {
        repository = MockMxCryptoRepository();
        when(() => repository.fetchAllCoins(queryParameters)).thenAnswer(
          (invocation) async => cryptoList,
        );
      });

      testWidgets('navigation test', (WidgetTester tester) async {
        var isPushed = false;
        _navObserver.attachPushRouteObserverWithArgs('MX_CRYPTO_DETAIL_SCREEN', (args) {
          isPushed = true;
          return () {};
        });
        await tester.pumpAndSettle();

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: mxCryptoCubit,
              child: TestMaterialApp(
                home: NavigatorScreen(
                  arguments: cryptoList.first,
                  targetRouteName: 'MX_CRYPTO_DETAIL_SCREEN',
                ),
                navigatorObserver: _navObserver,
              ),
            ),
            navigator: navigator,
          );
        });
        await tester.pumpAndSettle();

        expect(isPushed, true);

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: mxCryptoCubit,
              child: TestMaterialApp(
                home: const MxCryptoDetailScreen(),
                navigatorObserver: _navObserver,
              ),
            ),
            navigator: navigator,
          );
        });
        await tester.pumpAndSettle();

        var isPushed2 = false;
        _navObserver.attachPushRouteObserverWithArgs('MX_CRYPTO_DETAIL_SCREEN', (args) {
          isPushed2 = true;
          return () {};
        });
        await tester.pumpAndSettle();

        await mockNetworkImages(() async {
          await tester.pumpWidget(
            TestMaterialApp(
              home: const MxCryptoDetailScreen(),
              navigatorObserver: _navObserver,
            ),
          );
        });
        await tester.pumpAndSettle();

        final headerKey = find.byKey(const ValueKey('avatar-key'));
        expect(headerKey, findsOneWidget);
        await tester.tap(headerKey);
        expect(isPushed, true);
      });
    });
  });
}
