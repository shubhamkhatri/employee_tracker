import 'package:employee/features/employee/domain/entities/employee.dart';
import 'package:employee/features/employee/presentation/widgets/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders employee details with INR salary', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmployeeCard(
            employee: const Employee(
              id: 1,
              fullName: 'Aarav Sharma',
              jobTitle: 'Android Developer',
              country: 'India',
              salary: 850000,
            ),
            onEdit: () {},
            onDelete: () {},
          ),
        ),
      ),
    );

    expect(find.text('Aarav Sharma'), findsOneWidget);
    expect(find.text('Job Title: Android Developer'), findsOneWidget);
    expect(find.text('Country: India'), findsOneWidget);
    expect(find.text('Salary (INR): ₹850000.00'), findsOneWidget);
  });
}
