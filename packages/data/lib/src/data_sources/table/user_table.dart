import 'package:entities/entities.dart';
import 'package:hive/hive.dart';

part 'user_table.g.dart';

@HiveType(typeId: 0)
class UserTable {

  @HiveField(0)
  late String document; // campo único (clave externa lógica)

  @HiveField(1)
  String? year;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? session;


  // Convertir modelo -> entidad
  User toEntity() => User(document: document, name: name, year: year, session: session);

  // Convertir entidad -> modelo
  static UserTable fromEntity(User entity) => UserTable()
    ..document = entity.document
    ..name = entity.name
    ..year = entity.year
    ..session = entity.session;

}