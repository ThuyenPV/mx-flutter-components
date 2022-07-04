import 'package:flutter_test/flutter_test.dart';
import 'package:mx_flutter_components/app/app.dart';
import 'package:mx_flutter_components/home/view/home_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders HomeScreen', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
