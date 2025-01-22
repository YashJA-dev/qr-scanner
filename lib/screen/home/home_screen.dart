import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheets/gsheets.dart';
import 'package:qrscanner/bloc/scanner_qr_bloc/scanned_qr_bloc.dart';
import 'package:qrscanner/configs/app_colors.dart';
import 'package:qrscanner/configs/app_const.dart';
import 'package:qrscanner/repositories/sheet_api_repo.dart';
import 'package:qrscanner/screen/qr_list_page/qr_list_page.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../scanner_screen/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  int index = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<ScannedQrBloc>(
        create: (context) => ScannedQrBloc(
          sheetApiRepo: SheetApiRepo(
            gSheets: GSheets(AppConst.credentials),
          ),
        ),
        child: Scaffold(
          body: Builder(builder: (context) {
            return PageView.builder(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return ScannerScreen();
                  case 1:
                    return QRListScreen();
                }
              },
            );
          }),
          bottomNavigationBar: WaterDropNavBar(
            waterDropColor: AppColors.primary,
            bottomPadding: 8,
            backgroundColor: AppColors.black,
            onItemSelected: (index) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear);
              setState(() {
                this.index = index;
              });
            },
            selectedIndex: index,
            barItems: [
              BarItem(
                filledIcon: Icons.qr_code_scanner,
                outlinedIcon: Icons.qr_code_scanner_outlined,
              ),
              BarItem(
                filledIcon: Icons.list,
                outlinedIcon: Icons.list_alt_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
