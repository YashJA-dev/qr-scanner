import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrscanner/bloc/scanner_qr_bloc/scanned_qr_bloc.dart';
import 'package:qrscanner/components/custom_circular_indecator.dart';
import 'package:qrscanner/configs/app_colors.dart';
import 'package:qrscanner/dialog/toaster.dart';
import 'package:toastification/toastification.dart';

class QRListScreen extends StatelessWidget {
  final ScannedQrState state;
  const QRListScreen({required this.state});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          backgroundColor: AppColors.black,
          title: Text("QR List"),
          titleTextStyle: TextStyle(color: AppColors.white),
          centerTitle: true,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: (state is ScannedQrLoadedState)
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            crossAxisAlignment: (state is ScannedQrLoadedState)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (state is ScannedQrLoadedState && state.qrCodes.isNotEmpty)
                getQrCodes(state as ScannedQrLoadedState)
              else if ((state is ScannedQrLoadingState))
                CustomCircularIndicator()
              else if (state is ScannedQrInitialState || state.qrCodes.isEmpty)
                Center(
                  child: Text("NO Qr Scanned"),
                )
            ],
          ),
        ),
      ],
    );
  }

  Expanded getQrCodes(ScannedQrLoadedState state) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemCount: state.qrCodes.length,
          itemBuilder: (context, index) {
            return ListTile(
              iconColor: AppColors.black,
              subtitle: Text(
                state.qrCodes[index].url,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              title: Text(
                state.qrCodes[index].userName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: ClipOval(
                  child: Image(
                image: MemoryImage(
                  state.qrCodes[index].image,
                ),
                fit: BoxFit.cover,
                width: 60.0,
                height: 60.0,
              )),
              trailing: IconButton(
                onPressed: () async {
                  await Clipboard.setData(
                      ClipboardData(text: state.qrCodes[index].url));
                },
                icon: Icon(Icons.copy),
              ),
            );
          },
        ),
      ),
    );
  }
}
