import 'package:hive_ce/hive.dart';

part 'appuser.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
    String username;

  @HiveField(1)
    String password;

  User({required this.username, required this.password});
}

