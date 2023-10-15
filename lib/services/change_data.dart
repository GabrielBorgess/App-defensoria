import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> changeDataAuth(
    context, String token, String newAdress, String newPhone) async {
  String url = 'http://192.168.0.98:3000/assistido/alterarDados';

  // Realiza a solicitação POST
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {"novoEndereco": newAdress, "novoTelefone": newPhone},
  );

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
