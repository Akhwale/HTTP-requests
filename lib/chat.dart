import 'dart:convert';

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
  final controller = TextEditingController();
  bool _loading = false;
  String _response = "";

  void _askQuestion() {
    final endpoint = Uri.https('api.openai.com', 'v1/completions');
    final api_key = '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';
    final Map<String, String> headers = {
      'Authorization': "Bearer $api_key",
      "Content-Type": "application/json",
    };
    final Map<String, dynamic> payload = {
      "model": "text-davinci-003",
      "prompt": controller.text,
    };
    setState(() {
      _loading = true;
    });
    http.post(endpoint, headers: headers, body: jsonEncode(payload)).then(
      (response) {
        print({
          "status": response.statusCode,
          "body": response.body,
        });
        final json = jsonDecode(response.body);
        setState(() {
          _loading = false;
          _response = json["choices"][0]["text"];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Bot"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Ask me Anything!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _askQuestion,
                  child: Text("Ask"),
                ),
                SizedBox(width: 10),
                _loading ? CircularProgressIndicator() : SizedBox(),
              ],
            ),
            SizedBox(height: 20),
            Text(_response)
          ],
        ),
      ),
    );
  }
}
