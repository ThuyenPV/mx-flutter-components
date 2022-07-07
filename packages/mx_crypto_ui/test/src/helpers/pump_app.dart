import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mockingjay/mockingjay.dart';

class MockMxCryptoRepository extends Mock implements MxCryptoRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    MxCryptoRepository? mxCryptoRepository,
  }) {
    final innerChild = Scaffold(body: widget);

    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: mxCryptoRepository ?? MxCryptoRepository(),
          ),
        ],
        child: MaterialApp(
          home: navigator == null
              ? innerChild
              : MockNavigatorProvider(
                  navigator: navigator,
                  child: innerChild,
                ),
        ),
      ),
    );
  }
}
