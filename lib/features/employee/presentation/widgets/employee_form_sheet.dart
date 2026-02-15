import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/employee.dart';

Future<Employee?> showEmployeeFormSheet(
  BuildContext context, {
  Employee? employee,
}) {
  return showModalBottomSheet<Employee>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return _EmployeeFormSheet(employee: employee);
    },
  );
}

class _EmployeeFormSheet extends StatefulWidget {
  const _EmployeeFormSheet({this.employee});

  final Employee? employee;

  @override
  State<_EmployeeFormSheet> createState() => _EmployeeFormSheetState();
}

class _EmployeeFormSheetState extends State<_EmployeeFormSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _countryController;
  late final TextEditingController _salaryController;
  late String _selectedCountryName;
  String _selectedCountryFlag = '🇮🇳';

  @override
  void initState() {
    super.initState();
    _fullNameController =
        TextEditingController(text: widget.employee?.fullName ?? '');
    _jobTitleController =
        TextEditingController(text: widget.employee?.jobTitle ?? '');
    _selectedCountryName = widget.employee?.country ?? 'India';
    if (_selectedCountryName == 'India') {
      _selectedCountryFlag = '🇮🇳';
    } else {
      _selectedCountryFlag = '';
    }
    _countryController = TextEditingController(
      text: _formatCountryDisplay(_selectedCountryName, _selectedCountryFlag),
    );
    _salaryController = TextEditingController(
      text: widget.employee == null
          ? ''
          : widget.employee!.salary.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _jobTitleController.dispose();
    _countryController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        _selectedCountryName = country.name;
        _selectedCountryFlag = country.flagEmoji;
        _countryController.text = _formatCountryDisplay(
          _selectedCountryName,
          _selectedCountryFlag,
        );
      },
    );
  }

  String _formatCountryDisplay(String countryName, String flagEmoji) {
    if (flagEmoji.isEmpty) {
      return countryName;
    }
    return '$flagEmoji $countryName';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pop(
      Employee(
        id: widget.employee?.id,
        fullName: _fullNameController.text.trim(),
        jobTitle: _jobTitleController.text.trim(),
        country: _selectedCountryName,
        salary: double.parse(_salaryController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.employee == null ? 'Add Employee' : 'Edit Employee',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Full name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _jobTitleController,
              decoration: const InputDecoration(labelText: 'Job Title'),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Job title is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('country_field'),
              controller: _countryController,
              readOnly: true,
              onTap: _openCountryPicker,
              decoration: const InputDecoration(
                labelText: 'Country',
                hintText: 'Select country',
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Country is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _salaryController,
              decoration: const InputDecoration(
                labelText: 'Salary (INR)',
                prefixText: '₹ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Salary is required';
                }
                final double? salary = double.tryParse(value);
                if (salary == null || salary <= 0) {
                  return 'Enter a valid salary amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(widget.employee == null ? 'Add' : 'Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
