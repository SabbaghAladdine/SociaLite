
import 'package:hive_ce/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class Post extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final int upvote;
  @HiveField(4)
  final DateTime time;
  @HiveField(5)
  final String? imageURL;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.upvote,
    required this.time,
    this.imageURL,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      upvote: json['upvote'],
      time: DateTime.parse(json['time']),
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'upvote': upvote,
      'time': time.toIso8601String(),
      'imageURL': imageURL,
    };
  }
}
