import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> login(context, String cpf, String senha) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Realizando login..."),
          ],
        ),
      );
    },
  );

  Map<String, dynamic> request = {'cpf': cpf, 'senha': senha};

  final uri = Uri.parse("http://172.88.0.224:3000/entrar");
  try {
    final response = await http.post(uri, body: request);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody);
      if (responseBody.containsKey('firstAccess') != true) {
        String authToken = responseBody['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', authToken);

        Navigator.pushReplacementNamed(context, '/profile');
      } else if (responseBody.containsKey('firstAccess')) {
        String authToken = responseBody['token'];
        bool firstAccess = responseBody['firstAccess'];

        Navigator.pushReplacementNamed(context, '/primeiro_acesso');

        print('Token obtido: $authToken');
        print(firstAccess);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', authToken);
        print(responseBody);
      }
      return '';
    } else if (cpf.isEmpty || senha.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Os campos não podem estar vazios."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      print('Erro na solicitação POST: ${response.statusCode} ${response.body}');
      return '';
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("CPF e/ou senha incorretos. Tente novamente."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return '';
    }
  } catch (e) {
    print('Erro: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Falha ao realizar login. Tente novamente mais tarde."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
    return '';
  }
}


//-- Definir senha nova para primeiro acesso

Future<void> resetFirstLoginPass(context, String senha, String senha2) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token'); // Recupere o token de SharedPreferences

  if (token != null && senha == senha2) {
    String url = 'http://172.88.0.224:3000/reset';
    print('senha digitada na função: $senha');
    print('token de verificação na função: $token');

    Map<String, String> body = {
      'senha': senha,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      print('Solicitação POST bem-sucedida');
      print('Resposta: ${response.body}');
      Navigator.pushReplacementNamed(context, '/profile');
    } else if (response.statusCode == 500) {
      Navigator.pushReplacementNamed(context, '/error_screen');
    } else {
      print('Falha na solicitação POST');
      print('Código de status: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Falha ao realizar login. Tente novamente mais tarde."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
// Corpo da solicitação, você pode incluir a senha digitada pelo usuário aqui

// --