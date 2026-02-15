import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/emplyee/application/bloc/employee_bloc.dart';
import 'features/emplyee/data/repositories/in_memory_employee_repository.dart';
import 'features/emplyee/domain/repositories/employee_repository.dart';
import 'features/emplyee/presentation/views/employees_view.dart';

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeRepository employeeRepository = InMemoryEmployeeRepository();

    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: BlocProvider<EmployeeBloc>(
        create: (_) => EmployeeBloc(repository: employeeRepository),
        child: const EmployeesView(),
      ),
    );
  }
}
