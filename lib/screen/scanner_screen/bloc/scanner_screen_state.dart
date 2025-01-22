import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class ScannerScreenState extends Equatable {
  const ScannerScreenState();

  @override
  List<Object> get props => [];
}

class ScannerScreenInitial extends ScannerScreenState {}

class ScannerScreenLoading extends ScannerScreenState {}

class ToggleTourchState extends ScannerScreenState {
  final bool enabled;
  ToggleTourchState({required this.enabled});
  @override
  List<Object> get props => [enabled];
}

class ScannerScreenSuccess extends ScannerScreenState {
  final String qrCode;
  final Uint8List image;

  const ScannerScreenSuccess({required this.qrCode, required this.image});

  @override
  List<Object> get props => [qrCode, image];
}

class ScannerScreenFailure extends ScannerScreenState {
  final String error;

  const ScannerScreenFailure(this.error);

  @override
  List<Object> get props => [error];
}
