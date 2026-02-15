import 'package:flutter/material.dart';

class EmployeesLoadingView extends StatelessWidget {
  const EmployeesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 14),
          Text('Loading employee records...'),
        ],
      ),
    );
  }
}
