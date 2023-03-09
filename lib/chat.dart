import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class MyChatBot extends StatefulWidget {
  const MyChatBot({super.key});

  @override
  State<MyChatBot> createState() => _MyChatBotState();
}

class _MyChatBotState extends State<MyChatBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Bot"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [Text("Ask me Anything!")],
        ),
      ),
    );
  }
}
