import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class ScannerScreenEvent extends Equatable {
  const ScannerScreenEvent();

  @override
  List<Object> get props => [];
}

class ToggleTourchEvent extends ScannerScreenEvent {
  final bool enabled;
  ToggleTourchEvent({required this.enabled});
  @override
  List<Object> get props => [enabled];
}

class StopScan extends ScannerScreenEvent {}

class ScanSuccess extends ScannerScreenEvent {
  final String scannedData;
  final Uint8List image;

  const ScanSuccess({required this.scannedData, required this.image});

  @override
  List<Object> get props => [scannedData, image];
}

class ScanFailure extends ScannerScreenEvent {
  final String error;

  const ScanFailure(this.error);

  @override
  List<Object> get props => [error];
}
