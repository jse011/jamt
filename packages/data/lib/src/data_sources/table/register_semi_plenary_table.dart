import 'package:entities/entities.dart';
import 'package:hive/hive.dart';

part 'register_semi_plenary_table.g.dart';

@HiveType(typeId: 2)
class RegisterSemiPlenaryTable {

  @HiveField(0)
  late String semiPlenary;
  @HiveField(1)
  late String document;
  @HiveField(2)
  DateTime? timestamp;
  @HiveField(3)
  late String group;
  @HiveField(4)
  late String title;

  RegisterSemiPlenary toEntity() => RegisterSemiPlenary(
      semiPlenary: semiPlenary,
      document: document,
      timestamp: timestamp,
      group: group,
     title: title
  );

  static RegisterSemiPlenaryTable fromEntity(RegisterSemiPlenary entity) => RegisterSemiPlenaryTable()
    ..semiPlenary = entity.semiPlenary
    ..document = entity.document
    ..timestamp = entity.timestamp
      ..group = entity.group
      ..title = entity.title
  ;

}