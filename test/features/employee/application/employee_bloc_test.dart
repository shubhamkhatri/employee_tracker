import 'package:employee/features/employee/application/bloc/employee_bloc.dart';
import 'package:employee/features/employee/domain/entities/employee.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_employee_repository.dart';

void main() {
  group('EmployeeBloc', () {
    test('loads employees and seeds once', () async {
      final FakeEmployeeRepository repository = FakeEmployeeRepository(
        initialEmployees: const <Employee>[
          Employee(
            id: 1,
            fullName: 'Aarav Sharma',
            jobTitle: 'Android Developer',
            country: 'India',
            salary: 850000,
          ),
        ],
      );
      final EmployeeBloc bloc = EmployeeBloc(repository: repository);
      final List<EmployeeState> emitted = <EmployeeState>[];
      final subscription = bloc.stream.listen(emitted.add);

      bloc.add(const EmployeesLoaded());
      await bloc.stream.firstWhere((EmployeeState s) => s.status != EmployeeStatus.loading);

      expect(repository.seedCalls, 1);
      expect(emitted.first.status, EmployeeStatus.loading);
      expect(bloc.state.status, EmployeeStatus.success);
      expect(bloc.state.employees.length, 1);

      await subscription.cancel();
      await bloc.close();
    });

    test('adds employee and refreshes list', () async {
      final FakeEmployeeRepository repository = FakeEmployeeRepository();
      final EmployeeBloc bloc = EmployeeBloc(repository: repository);

      bloc.add(
        const EmployeeAdded(
          Employee(
            fullName: 'Priya Nair',
            jobTitle: 'QA Engineer',
            country: 'India',
            salary: 720000,
          ),
        ),
      );

      await bloc.stream.firstWhere((EmployeeState s) => s.status == EmployeeStatus.success);

      expect(bloc.state.employees.length, 1);
      expect(bloc.state.employees.first.fullName, 'Priya Nair');
      await bloc.close();
    });

    test('updates employee and refreshes list', () async {
      final FakeEmployeeRepository repository = FakeEmployeeRepository(
        initialEmployees: const <Employee>[
          Employee(
            id: 1,
            fullName: 'Rohan Verma',
            jobTitle: 'Product Manager',
            country: 'India',
            salary: 1400000,
          ),
        ],
      );
      final EmployeeBloc bloc = EmployeeBloc(repository: repository);

      bloc.add(
        const EmployeeUpdated(
          Employee(
            id: 1,
            fullName: 'Rohan Verma',
            jobTitle: 'Senior Product Manager',
            country: 'India',
            salary: 1550000,
          ),
        ),
      );

      await bloc.stream.firstWhere((EmployeeState s) => s.status == EmployeeStatus.success);

      expect(bloc.state.employees.single.jobTitle, 'Senior Product Manager');
      await bloc.close();
    });

    test('emits failure when fetch fails', () async {
      final FakeEmployeeRepository repository = FakeEmployeeRepository();
      repository.failFetch = true;
      final EmployeeBloc bloc = EmployeeBloc(repository: repository);

      bloc.add(const EmployeesLoaded());
      await bloc.stream.firstWhere((EmployeeState s) => s.status == EmployeeStatus.failure);

      expect(bloc.state.errorMessage, 'Failed to load employees.');
      await bloc.close();
    });
  });
}
