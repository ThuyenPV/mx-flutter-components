import 'package:flutter_test/flutter_test.dart';
import 'package:mx_flutter_components/app/app.dart';
import 'package:mx_flutter_components/dashboard/view/dashboard_screen.dart';

void main() {
  group('App', () {
    testWidgets('Renders root App', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(DashboardScreen), findsOneWidget);
    });
  });
}
