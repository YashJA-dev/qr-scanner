import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrscanner/bloc/scanner_qr_bloc/scanned_qr_bloc.dart';
import 'package:qrscanner/components/fields/custom_text_form_field.dart';
import 'package:qrscanner/configs/app_colors.dart';
import 'package:qrscanner/dialog/toaster.dart';
import 'package:qrscanner/extentions/list_extension.dart';
import 'package:qrscanner/model/qr_model.dart';
import 'package:qrscanner/screen/scanner_screen/bloc/scanner_screen_bloc.dart';
import 'package:qrscanner/screen/scanner_screen/bloc/scanner_screen_state.dart';
import 'package:toastification/toastification.dart';

import 'bloc/scanner_screen_event.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController _controller;
  late final TextEditingController _userNameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      torchEnabled: false,
      returnImage: true,
    );
    _userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext parentConext) {
    return BlocProvider<ScannerScreenBloc>(
      create: (context) => ScannerScreenBloc(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: BlocListener<ScannerScreenBloc, ScannerScreenState>(
            listener: (context, state) {
              if (state is ScannerScreenSuccess) {
                _userNameController.text = "";
                ToastMessage.show(
                    context: context,
                    title: "Success!",
                    description: "Please save the QR code to an Excel file",
                    toastificationType: ToastificationType.success);
                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: parentConext.read<ScannedQrBloc>(),
                      child: AlertDialog(
                        title: Tooltip(
                          message: state.qrCode,
                          child: Text(
                            state.qrCode,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Image(
                                image: MemoryImage(
                                  state.image,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: CustomTextFormField(
                                controller: _userNameController,
                                label: "User Name",
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter User Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ].separator(16),
                        ),
                        actions: [
                          TextButton(
                            child: Text("Save"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                parentConext.read<ScannedQrBloc>().add(
                                      ScannedQrAddEvent(
                                        qrModel: QRModel(
                                            url: state.qrCode,
                                            userName: _userNameController.text,
                                            image: state.image),
                                      ),
                                    );
                                GoRouter.of(context).pop();
                              }
                            },
                          ),
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              GoRouter.of(context).pop();
                              log("Cancel");
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (state is ScannerScreenFailure) {
                ToastMessage.show(
                    context: context,
                    title: "Scan Error",
                    description: "Something went wrong please try again!",
                    toastificationType: ToastificationType.error);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      MobileScanner(
                        controller: _controller,
                        onDetectError: (error, stackTrace) {
                          context.read<ScannerScreenBloc>().add(
                                ScanFailure(error.toString()),
                              );
                        },
                        onDetect: (capture) {
                          if (capture.image != null) {
                            context.read<ScannerScreenBloc>().add(
                                  ScanSuccess(
                                    image: capture.image!,
                                    scannedData:
                                        capture.barcodes.first.rawValue ?? "",
                                  ),
                                );
                          }
                        },
                      ),
                      BlocBuilder<ScannerScreenBloc, ScannerScreenState>(
                        buildWhen: (previous, current) =>
                            current is ToggleTourchState,
                        builder: (context, state) {
                          final isEnabled = (state is ToggleTourchState)
                              ? state.enabled
                              : _controller.torchEnabled;
                          return IconButton(
                            color: AppColors.primary,
                            icon: Icon(
                                isEnabled ? Icons.flash_on : Icons.flash_off),
                            onPressed: () {
                              _controller.toggleTorch();
                              context
                                  .read<ScannerScreenBloc>()
                                  .add(ToggleTourchEvent(enabled: !isEnabled));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
