import 'package:flutter/material.dart';
import 'package:my_learning/pharmacy/pages/loading_page.dart';
import 'package:my_learning/pharmacy/routes/pages.dart';


class Routes {
  final String name;
  final Widget Function() page;

  Routes({required this.name, required this.page});
}

class AppRoutes {
  static final routes = [
    Routes(
        name: Pages.loading,
        page: () => LoadingPage(),
    ),
  ];
}