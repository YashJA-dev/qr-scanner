part of 'scanned_qr_bloc.dart';

class ScannedQrState extends Equatable {
  const ScannedQrState();
  @override
  List<Object> get props => [];
}

class ScannedQrInitialState extends ScannedQrState {}

class ScannedQrLoadingState extends ScannedQrState {}

class ScannedQrLoadedState extends ScannedQrState {
  final List<QRModel> qrCodes;

  const ScannedQrLoadedState({required this.qrCodes});

  @override
  List<Object> get props => [qrCodes];
}

class ScannedQrErrorState extends ScannedQrState {
  final String error;

  const ScannedQrErrorState(this.error);

  @override
  List<Object> get props => [error];
}
