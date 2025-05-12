import 'package:equatable/equatable.dart';
import 'package:jamt/widget/widget.dart';

class QRMessage extends Equatable {
  final MessageType type;
  final String message;
  final bool show;

  const QRMessage.info(String message) : this._(show: true, type: MessageType.info, message: message);
  const QRMessage.error(String message) : this._( show: true, type: MessageType.error, message: message);
  const QRMessage.warning(String message) : this._(show: true,  type: MessageType.warning, message: message);
  const QRMessage.success(String message) : this._(show: true,  type: MessageType.success, message: message);

  const QRMessage.empty() : this._(show: false, type: MessageType.info, message: "");

  const QRMessage._({required this.show ,required this.type, required this.message});



  @override
  List<Object?> get props => [type, message, show];



}