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
    on<EmployeeAdded>(_onEmployeeAdded);
    on<EmployeeUpdated>(_onEmployeeUpdated);
    on<EmployeeDeleted>(_onEmployeeDeleted);
  }

  final EmployeeRepository _repository;

  Future<void> _onEmployeesLoaded(
    EmployeesLoaded event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(state.copyWith(status: EmployeeStatus.loading, errorMessage: null));
    await _emitEmployees(emit, failureMessage: 'Failed to load employees.');
  }

  Future<void> _onEmployeeAdded(
    EmployeeAdded event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      await _repository.createEmployee(event.employee);
      await _emitEmployees(emit, failureMessage: 'Failed to add employee.');
    } catch (_) {
      emit(
        state.copyWith(
          status: EmployeeStatus.failure,
          errorMessage: 'Failed to add employee.',
        ),
      );
    }
  }

  Future<void> _onEmployeeUpdated(
    EmployeeUpdated event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      await _repository.updateEmployee(event.employee);
      await _emitEmployees(
        emit,
        failureMessage: 'Failed to update employee.',
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: EmployeeStatus.failure,
          errorMessage: 'Failed to update employee.',
        ),
      );
    }
  }

  Future<void> _onEmployeeDeleted(
    EmployeeDeleted event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      await _repository.deleteEmployee(event.id);
      await _emitEmployees(
        emit,
        failureMessage: 'Failed to delete employee.',
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: EmployeeStatus.failure,
          errorMessage: 'Failed to delete employee.',
        ),
      );
    }
  }

  Future<void> _emitEmployees(
    Emitter<EmployeeState> emit, {
    required String failureMessage,
  }) async {
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
          errorMessage: failureMessage,
        ),
      );
    }
  }
}
