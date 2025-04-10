
import 'package:hive_ce/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 2)
class Message extends HiveObject{
  @HiveField(1)
  final String content;
  @HiveField(2)
  final String sender;
  @HiveField(3)
  final DateTime time;


  Message({
    required this.content,
    required this.sender,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      sender: json['sender'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': sender,
      'time': time.toIso8601String(),
    };
  }
}
