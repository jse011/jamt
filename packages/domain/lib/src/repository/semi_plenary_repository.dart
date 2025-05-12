import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

abstract class SemiPlenaryRepository {
  Stream<QrStatus> get qrStatus;
  void qrStatusDispose();
  Future<Either<RegisterSemiPlenaryFailure, QrState>> readQr(String fullQRText);
  Future<List<SemiPlenary>> semiPlenaries();
  Future<List<RegisterSemiPlenary>> getRegisterSemiPlenaries();
  Future<void> updateSemiPlenaries();
  Future<Either<RegisterSemiPlenaryFailure,void>> registerSemiPlenary(List<SemiPlenary> semiPlenaries);
}