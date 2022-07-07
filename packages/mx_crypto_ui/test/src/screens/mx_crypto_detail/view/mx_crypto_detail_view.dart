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
import '../../../helpers/test_app_constant.dart';
import '../../../helpers/test_material_app.dart';
import '../../../helpers/test_navigator_observer.dart';
import '../../../helpers/test_navigator_screen.dart';

class MockMxCryptoRepository extends Mock implements MxCryptoRepository {}

class MockMxCryptoCubit extends MockCubit<MxCryptoState> implements MxCryptoCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final queryParam = TestAppConstant.queryParameters;
  final cryptoList = TestAppConstant.listCrypto;

  group('CryptoView Testcases', () {
    late MxCryptoRepository mxCryptoRepository;

    setUp(() {
      mxCryptoRepository = MockMxCryptoRepository();
      when(() => mxCryptoRepository.fetchCrypto(queryParam)).thenAnswer(
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

  group('Testcases related to crypto detail screen', () {
    late MxCryptoCubit mxCryptoCubit;
    late MockNavigator navigator;
    late TestNavigatorObserver _navObserver;
    late MxCryptoRepository repository;

    setUp(() {
      _navObserver = TestNavigatorObserver();
      mxCryptoCubit = MockMxCryptoCubit();
      navigator = MockNavigator();
      when(() => navigator.push(any(that: isRoute<void>()))).thenAnswer((invocation) async {});

      ///
      repository = MockMxCryptoRepository();
      when(() => repository.fetchCrypto(queryParam)).thenAnswer(
        (invocation) async => cryptoList,
      );
    });

    setUpAll(() {
      registerFallbackValue(
        const MxCryptoState(status: FetchCryptoStatus.initial, cryptoList: []),
      );
    });

    testWidgets('transfer data from crypto screen to crypto detail screen', (tester) async {
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
    });
  });
}
