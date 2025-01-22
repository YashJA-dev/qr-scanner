import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrscanner/routing/routes_name.dart';
import 'package:qrscanner/screen/home/home_screen.dart';

class RoutesGenerator {
  GoRouter router = GoRouter(
    initialLocation: RoutesName.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutesName.home,
        builder: (context, state) => HomeScreen(),
      )
    ],
  );
}
