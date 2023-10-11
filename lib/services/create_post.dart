import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_state.dart';

Future<String> createPost(context, String cpf, String senha) async {
  Map<String, dynamic> request = {'cpf': cpf, 'senha': senha};

  final uri = Uri.parse("http://172.88.0.224:3000/entrar");
  final response = await http.post(uri, body: request);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    if (responseBody.containsKey('token')) {
      String authToken = responseBody['token'];
      bool firstAccess = responseBody ['firstAccess'];

      Navigator.pushReplacementNamed(context, '/primeiro_acesso');
      
      print('Token obtido: $authToken');
      print(firstAccess);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('auth_token', authToken);

      context.read<AuthState>().setAuthToken(authToken);


      return authToken;
    } else {
      throw Exception('Token not found in response');
    }
  } else {
    print('Erro na solicitação POST: ${response.statusCode} ${response.body}');
    throw Exception('Failed to load post');
  }
}

Future<void> createPostSenha(String senha, String token) async {
  // URL para a qual você deseja enviar a solicitação POST
  String url = 'http://172.88.0.224:3000/reset';

  // Cabeçalho personalizado, no exemplo, estamos adicionando um cabeçalho de autorização
  Map<String, String> headers = {
    'Authorization': token,// O tipo de conteúdo da solicitação
  };

  // Corpo da solicitação, você pode incluir a senha digitada pelo usuário aqui
  Map<String, String> body = {
    'senha': senha,
  };

  // Realiza a solicitação POST
  http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
  );

  // Verifica a resposta da solicitação
  if (response.statusCode == 200) {
    print('Solicitação POST bem-sucedida');
    print('Resposta: ${response.body}');
  } else {
    print('Falha na solicitação POST');
    print('Código de status: ${response.statusCode}');
    print('Resposta: ${response.body}');
  }
}

// Para chamar a função fazerPostRequest, você pode fazer isso em resposta a um evento, como um botão pressionado pelo usuário.





