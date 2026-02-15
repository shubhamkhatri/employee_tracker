import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required EmployeeRepository repository})
      : _repository = repository,
        super(const EmployeeState()) {
    on<EmployeesLoaded>(_onEmployeesLoaded);
  }

  final EmployeeRepository _repository;

  Future<void> _onEmployeesLoaded(
    EmployeesLoaded event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(state.copyWith(status: EmployeeStatus.loading));
    try {
      final List<Employee> employees = await _repository.fetchEmployees();
      emit(
        state.copyWith(
          status: EmployeeStatus.success,
          employees: employees,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: EmployeeStatus.failure,
          errorMessage: 'Failed to load employees.',
        ),
      );
    }
  }
}
