import 'package:flutter/material.dart';

class ApiResponse {
  int? statusCode;
  bool? successFlag;
  dynamic message;
  dynamic body;
  dynamic error;

  ApiResponse({@required this.statusCode, this.successFlag, this.body, this.error, this.message});
}
