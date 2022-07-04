import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mx_flutter_components/dashboard/home.dart';
import 'package:mx_flutter_components/dashboard/view/dashboard_screen.dart';

import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<int> implements DashboardCubit {}

void main() {
  group('DashboardScreen', () {
    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp(const DashboardScreen());
      expect(find.byType(DashboardView), findsOneWidget);
    });
  });

  group('HomeView', () {
    late DashboardCubit dashboardCubit;

    setUp(() {
      dashboardCubit = MockHomeCubit();
    });

    testWidgets('renders current count', (tester) async {
      const state = 42;
      when(() => dashboardCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: dashboardCubit,
          child: const DashboardScreen(),
        ),
      );
      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped', (tester) async {
      when(() => dashboardCubit.state).thenReturn(0);
      when(() => dashboardCubit.increment()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: dashboardCubit,
          child: const DashboardView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      verify(() => dashboardCubit.increment()).called(1);
    });

    testWidgets('calls decrement when decrement button is tapped', (tester) async {
      when(() => dashboardCubit.state).thenReturn(0);
      when(() => dashboardCubit.decrement()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: dashboardCubit,
          child: const DashboardView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => dashboardCubit.decrement()).called(1);
    });
  });
}
