import 'package:employee/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders employees screen', (WidgetTester tester) async {
    await tester.pumpWidget(const EmployeeApp());
    await tester.pumpAndSettle();

    expect(find.text('Employees'), findsOneWidget);
    expect(find.text('No employees yet. Tap + to add one.'), findsOneWidget);
  });
}
