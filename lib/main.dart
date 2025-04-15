import 'package:flutter/material.dart';

import 'screens/chat_page.dart'; // Importa a tela de chat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Porto Lines Offline',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF190B37),
      ),
      home: const ChatPage(),
      debugShowCheckedModeBanner: false, // Remove o debug banner
    );
  }
}