import 'package:flutter/material.dart';

enum AccountType {
  none,
  customer,
  technician,
}

class AccountTypeModel {
  const AccountTypeModel({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
  });

  final AccountType type;
  final String title;
  final String description;
  final IconData icon;
}
