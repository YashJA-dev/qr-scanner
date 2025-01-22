import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrscanner/model/qr_model.dart';
import 'package:qrscanner/repositories/sheet_api_repo.dart';

part 'scanned_qr_event.dart';
part 'scanned_qr_state.dart';

class ScannedQrBloc extends Bloc<ScannedQrEvent, ScannedQrState> {
  final SheetApiRepo sheetApiRepo;
  ScannedQrBloc({required this.sheetApiRepo}) : super(ScannedQrInitialState()) {
    on<ScannedQrDeleteEvent>(_scannedQrDeleteEvent);
    on<ScannedQrAddEvent>(_scannedQrAddEvent);
  }

  FutureOr<void> _scannedQrDeleteEvent(
      ScannedQrDeleteEvent event, Emitter<ScannedQrState> emit) {}

  FutureOr<void> _scannedQrAddEvent(
      ScannedQrAddEvent event, Emitter<ScannedQrState> emit) async {
    try {
      final currentState = state;
      emit(ScannedQrLoadingState());
      QRModel qrModel = event.qrModel.copyWith();
      await sheetApiRepo.insert({
        "User Name": qrModel.userName,
        "Url": qrModel.url,
      });

      if (currentState is ScannedQrLoadedState) {
        emit(
          ScannedQrLoadedState(qrCodes: currentState.qrCodes..add(qrModel)),
        );
      } else {
        emit(
          ScannedQrLoadedState(qrCodes: [qrModel]),
        );
      }
    } catch (e) {
      emit(ScannedQrErrorState("Error adding QR code"));
    }
  }
}
