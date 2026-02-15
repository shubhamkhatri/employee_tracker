import 'package:employee/features/employee/domain/entities/employee.dart';
import 'package:employee/features/employee/domain/repositories/employee_repository.dart';

class FakeEmployeeRepository implements EmployeeRepository {
  FakeEmployeeRepository({List<Employee>? initialEmployees})
      : _employees = List<Employee>.from(initialEmployees ?? <Employee>[]);

  final List<Employee> _employees;

  bool failSeed = false;
  bool failFetch = false;
  bool failCreate = false;
  bool failUpdate = false;
  bool failDelete = false;

  int seedCalls = 0;

  @override
  Future<void> seedDummyEmployeesIfEmpty() async {
    seedCalls += 1;
    if (failSeed) {
      throw Exception('seed failure');
    }
  }

  @override
  Future<List<Employee>> fetchEmployees() async {
    if (failFetch) {
      throw Exception('fetch failure');
    }
    return List<Employee>.from(_employees);
  }

  @override
  Future<Employee> createEmployee(Employee employee) async {
    if (failCreate) {
      throw Exception('create failure');
    }

    final int maxId = _employees.isEmpty
        ? 0
        : _employees
            .map((Employee e) => e.id ?? 0)
            .reduce((int a, int b) => a > b ? a : b);
    final Employee created = employee.copyWith(id: maxId + 1);
    _employees.insert(0, created);
    return created;
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    if (failUpdate) {
      throw Exception('update failure');
    }

    final int index = _employees.indexWhere((Employee e) => e.id == employee.id);
    if (index != -1) {
      _employees[index] = employee;
    }
  }

  @override
  Future<void> deleteEmployee(int id) async {
    if (failDelete) {
      throw Exception('delete failure');
    }

    _employees.removeWhere((Employee e) => e.id == id);
  }
}
