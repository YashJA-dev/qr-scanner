part of 'scanned_qr_bloc.dart';

class ScannedQrState extends Equatable {
  final List<QRModel> qrCodes;

  const ScannedQrState({required this.qrCodes});

  @override
  List<Object> get props => [...qrCodes];
}

class ScannedQrInitialState extends ScannedQrState {
  const ScannedQrInitialState() : super(qrCodes: const []);
}

class ScannedQrLoadingState extends ScannedQrState {
  const ScannedQrLoadingState(List<QRModel> qrCodes) : super(qrCodes: qrCodes);
}

class ScannedQrLoadedState extends ScannedQrState {
  const ScannedQrLoadedState(List<QRModel> qrCodes) : super(qrCodes: qrCodes);
}

class ScannedQrErrorState extends ScannedQrState {
  final String error;

  const ScannedQrErrorState(this.error, List<QRModel> qrCodes)
      : super(qrCodes: qrCodes);

  @override
  List<Object> get props => [error, ...qrCodes];
}
