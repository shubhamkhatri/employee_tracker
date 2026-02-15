import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/employee/application/bloc/employee_bloc.dart';
import 'features/employee/data/datasources/employee_local_datasource.dart';
import 'features/employee/data/repositories/employee_repository_impl.dart';
import 'features/employee/domain/repositories/employee_repository.dart';
import 'features/employee/presentation/views/employees_view.dart';

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeRepository employeeRepository = EmployeeRepositoryImpl(
      dataSource: EmployeeLocalDataSource.instance,
    );

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
