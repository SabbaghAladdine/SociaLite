import 'package:hive_ce/hive.dart';
import 'package:social_lite/models/appuser.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<User>(),
])

class HiveAdapters {}