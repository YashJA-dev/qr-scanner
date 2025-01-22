import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrscanner/configs/app_colors.dart';
import 'package:toastification/toastification.dart';

import 'routing/routes_generator.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e");
    return;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final RoutesGenerator routesGenerator = RoutesGenerator();
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: routesGenerator.router,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            shape: CircleBorder(),
            elevation: 4,
            backgroundColor: Colors.yellow,
          ),
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
      ),
    );
  }
}
