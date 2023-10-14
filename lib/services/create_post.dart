import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> createPost(context, String cpf, String senha) async {
  Map<String, dynamic> request = {'cpf': cpf, 'senha': senha};

  final uri = Uri.parse("http://192.168.0.98:3000/entrar");
  final response = await http.post(uri, body: request);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    print(responseBody);
    if (responseBody.containsKey('firstAccess') != true) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
    if (responseBody.containsKey('firstAccess')) {
      String authToken = responseBody['token'];
      bool firstAccess = responseBody['firstAccess'];

      Navigator.pushReplacementNamed(context, '/primeiro_acesso');

      print('Token obtido: $authToken');
      print(firstAccess);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', authToken);

      // context.read<AuthState>().setAuthToken(authToken);

      return authToken;
    } else {
      return 'Token not found in response';
    }
  } else {
    print('Erro na solicitação POST: ${response.statusCode} ${response.body}');
    return ('Failed to load post');
  }
}

Future<void> createPostSenha(context, String senha, String token) async {
  // URL para a qual você deseja enviar a solicitação POST
  String url = 'http://192.168.0.98:3000/reset';
  print('senha digitada ja na função: $senha');
  print('token de verificação ja na função: $token');

  // Corpo da solicitação, você pode incluir a senha digitada pelo usuário aqui
  Map<String, String> body = {
    'senha': senha,
  };

  // Realiza a solicitação POST
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: body,
  );

  // Verifica a resposta da solicitação
  if (response.statusCode == 201) {
    print('Solicitação POST bem-sucedida');
    print('Resposta: ${response.body}');
    Navigator.pushReplacementNamed(context, '/profile');
  } else {
    print('Falha na solicitação POST');
    print('Código de status: ${response.statusCode}');
    print('Resposta: ${response.body}');
  }
}

// Para chamar a função fazerPostRequest, você pode fazer isso em resposta a um evento, como um botão pressionado pelo usuário.





