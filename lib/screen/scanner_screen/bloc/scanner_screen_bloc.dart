import 'package:bloc/bloc.dart';
import 'package:qrscanner/screen/scanner_screen/bloc/scanner_screen_event.dart';
import 'package:qrscanner/screen/scanner_screen/bloc/scanner_screen_state.dart';

class ScannerScreenBloc extends Bloc<ScannerScreenEvent, ScannerScreenState> {
  ScannerScreenBloc() : super(ScannerScreenInitial()) {
    on<ToggleTourchEvent>(_toggleTourch);
    on<StopScan>(_stopScan);
    on<ScanSuccess>(_scanSuccess);
    on<ScanFailure>(_scanFailure);
  }

  void _toggleTourch(
      ToggleTourchEvent event, Emitter<ScannerScreenState> emit) {
    emit(ToggleTourchState(enabled: event.enabled));
  }

  void _stopScan(StopScan event, Emitter<ScannerScreenState> emit) {
    // Add your stop scan logic here
  }

  void _scanSuccess(ScanSuccess event, Emitter<ScannerScreenState> emit) {
    emit(ScannerScreenSuccess(image: event.image, qrCode: event.scannedData));
  }

  void _scanFailure(ScanFailure event, Emitter<ScannerScreenState> emit) {
    emit(ScannerScreenFailure(event.error));
  }
}
