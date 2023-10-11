import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> createPost(context, String cpf, String senha) async {
  Map<String, dynamic> request = {'cpf': cpf, 'senha': senha};

  final uri = Uri.parse("http://172.88.0.224:3000/entrar");
  final response = await http.post(uri, body: request);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    if (responseBody.containsKey('token')) {
      String token = responseBody['token'];

      print('Token obtido: $token');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', token);
      prefs.setInt('login_timestamp', DateTime.now().millisecondsSinceEpoch);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      throw Exception('Token not found in response');
    }
  } else {
    print('Erro na solicitação POST: ${response.statusCode} ${response.body}');
    throw Exception('Failed to load post');
  }
}
