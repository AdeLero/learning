import 'package:flutter/material.dart';

class AppRoutes {
  final String name;
  final Widget Function(dynamic argument)? page;

  AppRoutes({required this.name, required this.page});
}