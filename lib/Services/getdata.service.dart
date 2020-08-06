import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchQuote() async {
  final response = await http.get('https://pastebin.com/raw/jmhKjPLD');

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load quotes!');
  }
}