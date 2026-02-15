import 'package:employee/app.dart';
import 'package:employee/features/employee/domain/entities/employee.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_employee_repository.dart';

void main() {
  testWidgets('renders employees screen with injected fake repository', (
    WidgetTester tester,
  ) async {
    final FakeEmployeeRepository fakeRepository = FakeEmployeeRepository(
      initialEmployees: const <Employee>[
        Employee(
          id: 1,
          fullName: 'Aarav Sharma',
          jobTitle: 'Android Developer',
          country: 'India',
          salary: 850000,
        ),
      ],
    );

    await tester.pumpWidget(EmployeeApp(repository: fakeRepository));
    await tester.pumpAndSettle();

    expect(find.text('Employees'), findsOneWidget);
    expect(find.text('Aarav Sharma'), findsOneWidget);
  });
}
