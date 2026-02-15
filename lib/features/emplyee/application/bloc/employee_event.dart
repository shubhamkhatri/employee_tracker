part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class EmployeesLoaded extends EmployeeEvent {
  const EmployeesLoaded();
}
