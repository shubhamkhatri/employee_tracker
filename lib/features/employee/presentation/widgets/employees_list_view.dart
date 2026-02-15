import 'package:flutter/material.dart';

import '../../../../core/utils/indian_currency_formatter.dart';
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
    final double totalSalary = employees.fold(
      0,
      (double prev, Employee e) => prev + e.salary,
    );

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 90),
      itemCount: employees.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _SummaryTile(
            count: employees.length,
            totalSalary: totalSalary,
          );
        }

        final Employee employee = employees[index - 1];
        return EmployeeCard(
          employee: employee,
          onEdit: () => onEdit(employee),
          onDelete: () => onDelete(employee),
        );
      },
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.count,
    required this.totalSalary,
  });

  final int count;
  final double totalSalary;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: <Color>[
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _SummaryItem(
              label: 'Employees',
              value: '$count',
            ),
          ),
          Container(
            width: 1,
            height: 34,
            color: Colors.white.withOpacity(0.55),
          ),
          Expanded(
            child: _SummaryItem(
              label: 'Total Payroll',
              value: '₹${formatIndianCurrency(totalSalary, includeDecimals: false)}',
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.95),
              ),
        ),
      ],
    );
  }
}
