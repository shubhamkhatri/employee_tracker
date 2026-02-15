part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class EmployeesLoaded extends EmployeeEvent {
  const EmployeesLoaded();
}

final class EmployeeAdded extends EmployeeEvent {
  const EmployeeAdded(this.employee);

  final Employee employee;

  @override
  List<Object?> get props => <Object?>[employee];
}

final class EmployeeUpdated extends EmployeeEvent {
  const EmployeeUpdated(this.employee);

  final Employee employee;

  @override
  List<Object?> get props => <Object?>[employee];
}

final class EmployeeDeleted extends EmployeeEvent {
  const EmployeeDeleted(this.id);

  final int id;

  @override
  List<Object?> get props => <Object?>[id];
}
