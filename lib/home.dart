import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _loading = false;
  List _todos = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateToChatScreen() {
    Navigator.pushNamed(context, "/chat");
  }

  void _fetchTodos() {
    setState(() {
      _loading = true;
    });
    final endpoint = Uri.https('dummyjson.com', 'todos');
    http.get(endpoint).then((response) {
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json.containsKey('todos')) {
          setState(() {
            _todos = json["todos"];
          });
        }
      }

      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _loading ? null : _fetchTodos,
                  child: Text("Refresh"),
                ),
                SizedBox(width: 10),
                _loading ? CircularProgressIndicator() : SizedBox(),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final Map todo = _todos[index];
                  return ListTile(
                    title: Text(todo['todo']),
                    subtitle: Text(todo['completed'] ? 'completed' : 'pending'),
                  );
                },
                itemCount: _todos.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToChatScreen,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
