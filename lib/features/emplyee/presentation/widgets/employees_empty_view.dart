import 'package:flutter/material.dart';

class EmployeesEmptyView extends StatelessWidget {
  const EmployeesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No employees yet. Tap + to add one.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
