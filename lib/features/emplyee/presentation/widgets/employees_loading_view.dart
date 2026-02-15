import 'package:flutter/material.dart';

class EmployeesLoadingView extends StatelessWidget {
  const EmployeesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
