import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mx_flutter_components/dashboard/dashboard.dart';
import 'package:mx_flutter_components/config/app_router.dart';
import '../../helpers/test_material_app.dart';
import '../../helpers/test_navigator_observer.dart';

class MockDashboardCubit extends MockCubit<int> implements DashboardCubit {}

void main() {
  late TestNavigatorObserver _navObserver;

  setUp(() {
    _navObserver = TestNavigatorObserver();
  });

  _dashboardView() {
    return TestMaterialApp(
      home: DashboardScreen(),
      navigatorObserver: _navObserver,
    );
  }

  testWidgets("Renders dashboard screen", (tester) async {
    ///  given

    ///  when
    await tester.pumpWidget(_dashboardView());

    ///  then
    expect(find.byType(DashboardView), findsOneWidget);
  });

  testWidgets("Given dashboard screen then should be find the drawer menu icon", (tester) async {
    ///  given
    final drawerIconFinder = find.byKey(ValueKey('avatar-key'));

    ///  when

    ///  then
    expect(drawerIconFinder, findsOneWidget);
  });

  testWidgets("Given dashboard screen when user tap into menu drawer icon then show the drawer ", (tester) async {
    ///  given
    final avatarFinder = find.byKey(ValueKey('avatar-key'));
    await tester.tap(avatarFinder);
    await tester.pump();

    ///  when
    final drawerFinder = find.byKey(ValueKey('view-listed-crypto-item'));

    ///  then
    expect(drawerFinder, findsOneWidget);
  });

  testWidgets('Given dashboard screen when user tap into drawer icon and select one item then navigate to the crypto screen',
      (tester) async {
    /// given
    /// given : renders context
    await tester.pumpWidget(_dashboardView());

    /// given : find avatar widget
    final avatarFinder = find.byKey(ValueKey('avatar-key'));
    expect(avatarFinder, findsOneWidget);
    await tester.tap(avatarFinder);
    await tester.pump();

    /// given : navigator
    var isPushed = false;
    _navObserver.attachPushRouteObserver(AppRouter.MX_CRYPTO_SCREEN_ROUTE, () {
      isPushed = true;
    });
    await tester.pumpAndSettle();

    ///  when
    final drawerFinder = find.byKey(ValueKey('view-listed-crypto-item'));
    expect(avatarFinder, findsOneWidget);
    await tester.tap(drawerFinder, warnIfMissed: false);
    await tester.pumpAndSettle();

    ///  then
    expect(isPushed, true);
  });
}
