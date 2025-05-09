part of 'qr_bloc.dart';

final class QrState extends Equatable{

  const QrState({
    this.startScan = false,
    this.code = ""
  });

  final String code;
  final bool startScan;

  @override
  List<Object?> get props => [code, startScan];

  QrState copyWith({
    String? code,
    bool? startScan,
  }) {
    return QrState(
      code: code ?? this.code,
      startScan: startScan ?? this.startScan
    );
  }

}
