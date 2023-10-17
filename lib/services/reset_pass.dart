import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> cpfSearchReset(context, String cpf) async {
  String url = 'http://172.88.0.224:3000/recuperacao';

  // Realiza a solicitação POST
  http.Response response = await http.post(Uri.parse(url), body: {"cpf": cpf});
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
  } else {
    print('Falha na solicitação POST');
    print('Código de status: ${response.statusCode}');
    print('Resposta: ${response.body}');
  }
}

Future<void> resetPassAuth(
    context, String token, String emailCode, String newPass) async {
  String url = 'http://172.88.0.224:3000/recuperacaoCod';

  // Realiza a solicitação POST
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {"code": emailCode, "newPassword": newPass},
  );

if (response.statusCode == 201) {
    print('Solicitação POST bem-sucedida');
    print('Resposta: ${response.body}');
  } else if(response.statusCode == 400) {
    Navigator.pushReplacementNamed(context, '/error_screen');
  } else {
    print('Falha na solicitação POST');
    print('Código de status: ${response.statusCode}');
    print('Resposta: ${response.body}');
  }
}
