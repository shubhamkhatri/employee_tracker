import '../../domain/entities/employee.dart';

class EmployeeModel {
  const EmployeeModel({
    this.id,
    required this.fullName,
    required this.jobTitle,
    required this.country,
    required this.salary,
  });

  final int? id;
  final String fullName;
  final String jobTitle;
  final String country;
  final double salary;

  factory EmployeeModel.fromMap(Map<String, Object?> map) {
    return EmployeeModel(
      id: map['id'] as int?,
      fullName: map['full_name'] as String,
      jobTitle: map['job_title'] as String,
      country: map['country'] as String,
      salary: (map['salary'] as num).toDouble(),
    );
  }

  factory EmployeeModel.fromEntity(Employee employee) {
    return EmployeeModel(
      id: employee.id,
      fullName: employee.fullName,
      jobTitle: employee.jobTitle,
      country: employee.country,
      salary: employee.salary,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'id': id,
      'full_name': fullName,
      'job_title': jobTitle,
      'country': country,
      'salary': salary,
    };
  }

  Employee toEntity() {
    return Employee(
      id: id,
      fullName: fullName,
      jobTitle: jobTitle,
      country: country,
      salary: salary,
    );
  }
}
