import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String joke = '';

  Future getDadJoke() async {
    try {
      var url = "https://icanhazdadjoke.com/";
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        String body = json.decode(response.body)['joke'];

        setState(() {
          joke = body;
        });
      } else {
        setState(() {
          joke = 'An error has occurred...';
        });
      }
    } catch (e) {
      setState(() {
        joke = 'An error has occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              joke,
              style: const TextStyle(fontSize: 64),
            ),
            ElevatedButton(
              onPressed: getDadJoke,
              child: const Text('Get Joke'),
            ),
          ],
        ),
      ),
    );
  }
}
