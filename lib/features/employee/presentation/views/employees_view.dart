import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc/employee_bloc.dart';
import '../../domain/entities/employee.dart';
import '../widgets/add_employee_fab.dart';
import '../widgets/employees_empty_view.dart';
import '../widgets/employees_list_view.dart';
import '../widgets/employees_loading_view.dart';
import '../widgets/employee_form_sheet.dart';

class EmployeesView extends StatefulWidget {
  const EmployeesView({super.key});

  @override
  State<EmployeesView> createState() => _EmployeesViewState();
}

class _EmployeesViewState extends State<EmployeesView> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(const EmployeesLoaded());
  }

  Future<void> _openAddSheet() async {
    final Employee? newEmployee = await showEmployeeFormSheet(context);
    if (!mounted || newEmployee == null) {
      return;
    }
    context.read<EmployeeBloc>().add(EmployeeAdded(newEmployee));
  }

  Future<void> _openEditSheet(Employee employee) async {
    final Employee? updated = await showEmployeeFormSheet(
      context,
      employee: employee,
    );
    if (!mounted || updated == null) {
      return;
    }
    context.read<EmployeeBloc>().add(EmployeeUpdated(updated));
  }

  Future<void> _confirmDelete(Employee employee) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Employee'),
          content: Text('Delete ${employee.fullName}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true || employee.id == null) {
      return;
    }

    context.read<EmployeeBloc>().add(EmployeeDeleted(employee.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees')),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (BuildContext context, EmployeeState state) {
          if (state.status == EmployeeStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (BuildContext context, EmployeeState state) {
          if (state.status == EmployeeStatus.loading) {
            return const EmployeesLoadingView();
          }

          if (state.employees.isEmpty) {
            return const EmployeesEmptyView();
          }

          return EmployeesListView(
            employees: state.employees,
            onEdit: _openEditSheet,
            onDelete: _confirmDelete,
          );
        },
      ),
      floatingActionButton: AddEmployeeFab(onPressed: _openAddSheet),
    );
  }
}
