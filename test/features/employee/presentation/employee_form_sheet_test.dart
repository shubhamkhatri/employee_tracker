import 'package:employee/features/employee/presentation/widgets/employee_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows India as default country and INR salary label', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () => showEmployeeFormSheet(context),
                child: const Text('open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('Salary (INR)'), findsOneWidget);

    final TextFormField countryField = tester.widget<TextFormField>(
      find.byKey(const Key('country_field')),
    );
    expect(countryField.controller?.text, '🇮🇳 India');
  });
}
