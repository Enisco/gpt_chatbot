import 'package:flutter/material.dart';
import 'package:gpt_chatbot/ui/chat_page.dart/chat_page.dart';

void main() {
  runApp(const GPTChatApp());
}

class GPTChatApp extends StatelessWidget {
  const GPTChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT ChatBot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ChatBotScreen(),
    );
  }
}
