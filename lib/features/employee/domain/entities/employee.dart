import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  const Employee({
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

  Employee copyWith({
    int? id,
    String? fullName,
    String? jobTitle,
    String? country,
    double? salary,
  }) {
    return Employee(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      jobTitle: jobTitle ?? this.jobTitle,
      country: country ?? this.country,
      salary: salary ?? this.salary,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, fullName, jobTitle, country, salary];
}
