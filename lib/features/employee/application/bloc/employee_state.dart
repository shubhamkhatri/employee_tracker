part of 'employee_bloc.dart';

enum EmployeeStatus { initial, loading, success, failure }

class EmployeeState extends Equatable {
  const EmployeeState({
    this.status = EmployeeStatus.initial,
    this.employees = const <Employee>[],
    this.errorMessage,
  });

  final EmployeeStatus status;
  final List<Employee> employees;
  final String? errorMessage;

  EmployeeState copyWith({
    EmployeeStatus? status,
    List<Employee>? employees,
    String? errorMessage,
  }) {
    return EmployeeState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, employees, errorMessage];
}
