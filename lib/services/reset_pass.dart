import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> cpfSearchReset(context, String cpf) async {
showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(), // Ícone de carregamento
            SizedBox(height: 16),
            Text("Aguarde, o código está sendo enviado para o e-mail cadastrado."), // Texto informativo
          ],
        ),
      );
    },
  );
 try {
  Map<String, dynamic> request = {'cpf': cpf};
  final uri = Uri.parse('http://172.88.0.224:3000/recuperacao');
  final response = await http.post(uri, body: request);

  Navigator.pop(context);

  if (response.statusCode == 201) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    String resetToken = responseBody['token'];

    //Armazernar token globalmente
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('reset_token', resetToken);

    print('Solicitação POST bem-sucedida');
    print('Resposta: ${response.body}');
    print('token armazenado: $resetToken');
    Navigator.pushReplacementNamed(context, '/resetpass_auth');
    
  } else if (cpf.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("O campo não pode estar vazio."),
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
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("CPF não cadastrado."),
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
} catch (e) {
  print('Falha na solicitação POST');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Falha na solicitação. Tente novamente mais tarde."),
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
  // Realiza a solicitação POST
  

Future<void> resetPassAuth(
    context, String token, String emailCode, String newPass1, String newPass2) async {
  String url = 'http://172.88.0.224:3000/recuperacaoCod';

  if (newPass1.isEmpty || newPass2.isEmpty) {
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
  } else if (newPass1 == newPass2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Alterando a senha..."),
            ],
          ),
        );
      });

    // Realiza a solicitação POST
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {"code": emailCode, "newPassword": newPass1},
    );

    Navigator.pop(context); // Fecha o diálogo de carregamento

    if (response.statusCode == 201) {
      print('Solicitação POST bem-sucedida');
      print('Resposta: ${response.body}');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Falha ao realizar a troca de senha. Tente novamente mais tarde."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ]
          );});
      print('Resposta: ${response.body}');
    }
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Senhas não conferem."),
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

