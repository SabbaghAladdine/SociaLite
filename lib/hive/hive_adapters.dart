import 'package:hive_ce/hive.dart';
import 'package:social_lite/models/appuser.dart';
import 'package:social_lite/models/message.dart';
import 'package:social_lite/models/post.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<User>(),
  AdapterSpec<Post>(),
  AdapterSpec<Message>()
])

class HiveAdapters {}