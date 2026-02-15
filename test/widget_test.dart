import 'package:employee/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders employees screen shell', (WidgetTester tester) async {
    await tester.pumpWidget(const EmployeeApp());
    await tester.pumpAndSettle();

    expect(find.text('Employees'), findsOneWidget);
    expect(
      find.text('Employee feature is ready for CRUD implementation.'),
      findsOneWidget,
    );
  });
}
