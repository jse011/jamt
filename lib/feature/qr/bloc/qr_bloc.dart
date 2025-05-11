import 'package:bloc/bloc.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc() : super(QrState()) {
    on<QRPageSubscriptionRequested>(_onQRPageSubscriptionRequested);
    on<CodeScanData>(_onCodeScanData);
  }

  void _onQRPageSubscriptionRequested(
      QRPageSubscriptionRequested event,
        Emitter<QrState> emit
      ){
    state.copyWith(
        startScan: true
    );
  }

  void _onCodeScanData(
      CodeScanData event,
      Emitter<QrState> emit
      ){

      final code = event.code;

      

      var scanQR = ScanQR(
        type: TypeScanQR.entryToSemiPlenary,
        semiPlenary: ""
      );



    emit(
        state.copyWith(
            code: event.code
        )
    );
  }
}
