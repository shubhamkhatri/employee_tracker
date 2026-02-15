import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee_local_datasource.dart';
import '../models/employee_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl({required EmployeeLocalDataSource dataSource})
      : _dataSource = dataSource;

  final EmployeeLocalDataSource _dataSource;

  @override
  Future<void> seedDummyEmployeesIfEmpty() async {
    await _dataSource.seedDummyEmployeesIfEmpty();
  }

  @override
  Future<List<Employee>> fetchEmployees() async {
    final List<EmployeeModel> models = await _dataSource.fetchEmployees();
    return models.map((EmployeeModel model) => model.toEntity()).toList();
  }

  @override
  Future<Employee> createEmployee(Employee employee) async {
    final EmployeeModel model = EmployeeModel.fromEntity(employee);
    final EmployeeModel created = await _dataSource.createEmployee(model);
    return created.toEntity();
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final EmployeeModel model = EmployeeModel.fromEntity(employee);
    await _dataSource.updateEmployee(model);
  }

  @override
  Future<void> deleteEmployee(int id) async {
    await _dataSource.deleteEmployee(id);
  }
}
