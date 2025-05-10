import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

abstract class SemiPlenaryRepository {
  Future<String?> readQr(String code);
  Future<List<SemiPlenary>> semiPlenaries();
  Future<List<RegisterSemiPlenary>> getRegisterSemiPlenaries();
  Future<void> updateSemiPlenaries();
  Future<Either<RegisterSemiPlenaryFailure,void>> registerSemiPlenary(List<SemiPlenary> semiPlenaries);
}