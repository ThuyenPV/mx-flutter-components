import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_flutter_components/dashboard/dashboard.dart';
import '../../helpers/helpers.dart';

class MockDashboardCubit extends MockCubit<int> implements DashboardCubit {}

void main() {
  group('DashboardScreen', () {
    testWidgets('renders DashboardScreen', (tester) async {
      await tester.pumpApp(const DashboardScreen());
      expect(find.byType(DashboardView), findsOneWidget);
    });
  });

  group('HomeView', () {
    testWidgets('renders current count', (WidgetTester tester) async {
      await tester.pumpApp(DashboardScreen());

      final avatarFinder = find.byKey(ValueKey('avatar-key'));
      expect(avatarFinder, findsOneWidget);
      await tester.tap(avatarFinder);
      await tester.pump();

      final drawerFinder = find.byKey(ValueKey('view-listed-crypto-item'));
      expect(avatarFinder, findsOneWidget);
      await tester.tap(drawerFinder, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(MxCryptoScreen(), isNotNull);

      // final cryptoScreen = find.byType(MxCryptoScreen);
      // expect(cryptoScreen, findsOneWidget);
    });
  });
}
