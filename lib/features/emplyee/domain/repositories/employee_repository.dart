import '../entities/employee.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> fetchEmployees();
  Future<Employee> createEmployee(Employee employee);
  Future<void> updateEmployee(Employee employee);
  Future<void> deleteEmployee(int id);
}
