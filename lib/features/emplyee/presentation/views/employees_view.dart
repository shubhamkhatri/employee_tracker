import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc/employee_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees')),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (BuildContext context, EmployeeState state) {
          if (state.status == EmployeeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == EmployeeStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Unknown error'));
          }
          return const Center(
            child: Text('Employee feature is ready for CRUD implementation.'),
          );
        },
      ),
    );
  }
}
