import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:social_lite/commons/apiIp.dart';
import 'package:social_lite/models/message.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';


class ChatProvider extends GetConnect with ChangeNotifier {
  final List<Message> messages = [];
  StompClient? _stompClient;
  dynamic unsubscribeFn;
  bool isConnected = false;


  void connectSocket() {
    if(!isConnected){
      _stompClient = StompClient(
        config: StompConfig(
          url: 'ws://${ApiIp.apiIp}/ws',
          onConnect: _onStompConnected,
          onWebSocketError: (err) => debugPrint("STOMP error: $err"),
          onDisconnect: (_) => debugPrint("STOMP disconnected"),
          onStompError: (frame) => debugPrint("STOMP error: ${frame.body}"),
          beforeConnect: () async {
            debugPrint('Connecting to WebSocket...');
            await Future.delayed(const Duration(milliseconds: 500));
          },
        ),
      );

      _stompClient!.activate();
    }else{
      debugPrint("socket already connected");
    }
  }

  void _onStompConnected(StompFrame frame) {
    isConnected = true;
    debugPrint('Connected to STOMP');
    unsubscribeFn = _stompClient!.subscribe(
      destination: '/topic/group',
      callback: (frame) async {
        if (frame.body != null) {
          final data = json.decode(frame.body!);
          final message = Message.fromJson(data);
          messages.add(message);
          await saveMessage(message);
          notifyListeners();
        }
      },
    );
  }

  Future<void> sendMessage(Message message) async {
    _stompClient?.send(
      destination: '/app/chat',
      body: json.encode(message.toJson()),
    );
    notifyListeners();
  }

  Future<void> saveMessage(Message m) async {
    var box = await Hive.openBox<Message>('message');
    await box.add(m);
  }

  Future<void> loadMessages() async {
    var box = await Hive.openBox<Message>('message');
    messages.clear();
    messages.addAll(box.values.toList());
    notifyListeners();
  }

  void disconnectSocket() {
    _stompClient?.deactivate();
    isConnected = false;
    _stompClient = null;
  }
}