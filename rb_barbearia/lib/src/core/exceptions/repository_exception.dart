import 'package:flutter/services.dart';

class RepositoryException implements Exception {
  RepositoryException({
    required this.message,
  });

  final String message;
}
