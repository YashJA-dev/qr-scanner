import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
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
      emit(ScannedQrLoadingState(currentState.qrCodes));
      QRModel qrModel = event.qrModel.copyWith();
      bool sucess = await sheetApiRepo.insert({
        "User Name": qrModel.userName,
        "Url": qrModel.url,
        "Date Time": DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
      });
      List<QRModel> qrCodes = List.from(currentState.qrCodes);
      if (sucess) {
        emit(ScannedQrLoadedState(qrCodes..add(qrModel)));
      } else {
        emit(ScannedQrLoadedState(qrCodes));
        emit(ScannedQrErrorState(
            "Error adding QR code Please try again!", qrCodes));
      }
    } catch (e) {
      log("ERROR ${e.toString()}");
      emit(ScannedQrErrorState("Error adding QR code", state.qrCodes));
    }
  }
}
