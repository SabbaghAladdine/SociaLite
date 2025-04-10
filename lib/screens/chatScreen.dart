import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_lite/models/appuser.dart';
import 'package:social_lite/models/message.dart';
import 'package:social_lite/services/chatProvider.dart';
import 'package:social_lite/services/loginProvider.dart';
import 'package:social_lite/widgets/messageContainer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      debugPrint("chatpro");
      chatProvider.loadMessages();
      chatProvider.connectSocket();
    });
  }

  @override
  Widget build(BuildContext context) {

    final chatProvider = Provider.of<ChatProvider>(context, listen: true);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    User? user = loginProvider.currentUser;

    void sendMessage() {
      Message m;
      _controller.text.trim().isEmpty
          ? {}
          : {
        m = Message(content: _controller.text.trim(), sender: user!.username, time: DateTime.now()),
        chatProvider.sendMessage(m),
              _controller.clear()};
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Room"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // newest messages at the bottom
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                return MessageContainer(message: chatProvider.messages[chatProvider.messages.length - 1 - index]);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => sendMessage(),
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
