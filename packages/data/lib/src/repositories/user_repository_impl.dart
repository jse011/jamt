import 'package:data/src/data_sources/local_database.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class UserRepositoryImpl extends UserRepository {

  //final AppDatabase _db = AppDatabase.getInstance();

  @override
  Future<User?> getUser() async {
    //final user = await (_db.select(_db.users)..limit(1)).getSingleOrNull();
    //if(user == null) return null;
    return User(
      document: '2',
      year: '22',
      name: '22'
    );
  }

}