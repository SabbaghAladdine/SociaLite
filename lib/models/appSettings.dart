import 'package:hive_ce/hive.dart';

part 'appSettings.g.dart';

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  bool darkTheme;

  Settings({required this.darkTheme});
}
