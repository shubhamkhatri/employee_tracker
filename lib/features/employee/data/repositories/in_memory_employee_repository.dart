import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';

class InMemoryEmployeeRepository implements EmployeeRepository {
  final List<Employee> _employees = <Employee>[];

  @override
  Future<List<Employee>> fetchEmployees() async {
    return List<Employee>.from(_employees);
  }

  @override
  Future<Employee> createEmployee(Employee employee) async {
    final int nextId = _employees.isEmpty
        ? 1
        : (_employees
                .map((Employee e) => e.id ?? 0)
                .reduce((int a, int b) => a > b ? a : b)) +
            1;
    final Employee created = employee.copyWith(id: nextId);
    _employees.insert(0, created);
    return created;
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final int index = _employees.indexWhere((Employee e) => e.id == employee.id);
    if (index != -1) {
      _employees[index] = employee;
    }
  }

  @override
  Future<void> deleteEmployee(int id) async {
    _employees.removeWhere((Employee e) => e.id == id);
  }
}
