import 'package:flutter/material.dart';

import '../../domain/entities/employee.dart';
import 'employee_card.dart';

class EmployeesListView extends StatelessWidget {
  const EmployeesListView({
    super.key,
    required this.employees,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Employee> employees;
  final ValueChanged<Employee> onEdit;
  final ValueChanged<Employee> onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: employees.length,
      itemBuilder: (BuildContext context, int index) {
        final Employee employee = employees[index];
        return EmployeeCard(
          employee: employee,
          onEdit: () => onEdit(employee),
          onDelete: () => onDelete(employee),
        );
      },
    );
  }
}
