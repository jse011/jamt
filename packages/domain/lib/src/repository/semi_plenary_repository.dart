import 'package:entities/entities.dart';

abstract class SemiPlenaryRepository {
  Future<String?> readQr(String code);
  Future<List<SemiPlenary>> semiPlenaries();
  Future<void> updateSemiPlenaries();
}