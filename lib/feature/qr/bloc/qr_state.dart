part of 'qr_bloc.dart';

final class QrState extends Equatable{

  const QrState({
    this.startScan = false,
    this.qrMessage = const QRMessage.empty()
  });


  final bool startScan;
  final QRMessage qrMessage;

  @override
  List<Object?> get props => [ startScan, qrMessage];

  QrState copyWith({bool? startScan, QRMessage? qrMessage}) {
    return QrState(
      startScan: startScan ?? this.startScan,
      qrMessage: qrMessage ?? this.qrMessage,
    );
  }
}
