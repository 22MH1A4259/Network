import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _data = [];

  Future<void> getNotes() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    Center(
      child: CircularProgressIndicator(),
    );

    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Netorking',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: FloatingActionButton(
            onPressed: getNotes,
            child: Icon(Icons.search),
          ),
        ),
        body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_data[index]['title']),
              subtitle: Text(_data[index]['body']),
              leading: Text(
                _data[index]['id'].toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}
