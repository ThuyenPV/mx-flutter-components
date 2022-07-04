import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_flutter_components/home/home.dart';

import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<int> implements HomeCubit {}

void main() {
  group('HomeScreen', () {
    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp(const HomeScreen());
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    late HomeCubit homeCubit;

    setUp(() {
      homeCubit = MockHomeCubit();
    });

    testWidgets('renders current count', (tester) async {
      const state = 42;
      when(() => homeCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );
      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped', (tester) async {
      when(() => homeCubit.state).thenReturn(0);
      when(() => homeCubit.increment()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => homeCubit.increment()).called(1);
    });

    testWidgets('calls decrement when decrement button is tapped', (tester) async {
      when(() => homeCubit.state).thenReturn(0);
      when(() => homeCubit.decrement()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => homeCubit.decrement()).called(1);
    });
  });
}
