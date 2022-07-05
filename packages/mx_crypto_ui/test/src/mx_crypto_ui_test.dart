import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';

void main() {
  group('DashboardScreen', () {
    testWidgets('renders MxCryptoDetailScreen', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MxCryptoScreen()));
      expect(find.byType(MxCryptoDetailScreen), findsOneWidget);
    });

    testWidgets('renders MxCryptoScreen', (tester) async {
      await tester.pumpWidget(const MxCryptoScreen());
      expect(find.byType(MxCryptoScreen), findsOneWidget);
    });
  });

  group('HomeView', () {
    testWidgets('renders current count', (WidgetTester tester) async {
      await tester.pumpWidget(const MxCryptoScreen());

      // final avatarFinder = find.byKey(ValueKey('avatar-key'));
      // expect(avatarFinder, findsOneWidget);
      // await tester.tap(avatarFinder);
      // await tester.pump();
      //
      // final drawerFinder = find.byKey(ValueKey('view-listed-crypto-item'));
      // expect(avatarFinder, findsOneWidget);
      // await tester.tap(drawerFinder, warnIfMissed: false);
      // await tester.pumpAndSettle();
      // expect(MxCryptoScreen(), isNotNull);

      // final cryptoScreen = find.byType(MxCryptoScreen);
      // expect(cryptoScreen, findsOneWidget);
    });
  });
}
