part of 'scanned_qr_bloc.dart';

class ScannedQrEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ScannedQrDeleteEvent extends ScannedQrEvent {
  final int index;

  ScannedQrDeleteEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class ScannedQrAddEvent extends ScannedQrEvent {
  final QRModel qrModel;

  ScannedQrAddEvent({required this.qrModel});

  @override
  List<Object> get props => [qrModel];
}
