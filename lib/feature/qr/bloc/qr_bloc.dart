import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/qr/models/models.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc({
    required DecryptSemiPlenaryQr decryptSemiPlenaryQr
}) : _decryptSemiPlenaryQr = decryptSemiPlenaryQr
  ,super(QrState()) {
    on<QRPageSubscriptionRequested>(_onQRPageSubscriptionRequested);
    on<CodeScanData>(_onCodeScanData);
  }

  final DecryptSemiPlenaryQr _decryptSemiPlenaryQr;

  void _onQRPageSubscriptionRequested(
      QRPageSubscriptionRequested event,
        Emitter<QrState> emit
      ){
      emit(state.copyWith(
          qrMessage: QRMessage.empty(),
          startScan: true
      ));
  }

  void _onCodeScanData(
      CodeScanData event,
      Emitter<QrState> emit
      ) async{

      var result = await _decryptSemiPlenaryQr.call(event.code);
      result.fold((failure){
        if (failure is InvalidSemiPlenaryQr) {
          emit(state.copyWith(
            qrMessage: QRMessage.error("El código QR no es válido o está dañado."),
          ));
        } else if (failure is UnknownSemiPlenaryQr) {
          emit(state.copyWith(
            qrMessage: QRMessage.warning("El QR pertenece a otro tipo de evento o acción no reconocida."),
          ));
        }
      }, (checkIn) {
        state.copyWith(
            qrMessage: QRMessage.empty(),
            startScan: false
        );
      });
  }
}
