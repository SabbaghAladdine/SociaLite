
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_lite/models/message.dart';
import 'package:social_lite/services/loginProvider.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final currentuser =  loginProvider.currentUser;
    final isUser = currentuser?.username==message.sender;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Align(
        alignment: isUser?(Alignment.centerRight):(Alignment.centerLeft),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.sender),
            Container(
              decoration: BoxDecoration(
                color:isUser? Colors.blueAccent:Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                message.content,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}