import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> changeDataAuth(context, String token, String newAddress, String newPhone, Uint8List? fileBytes) async {
  String url = 'http://172.88.0.224:3000/assistido/alterarDados';

  if (newAddress.isEmpty && newPhone.isEmpty && fileBytes == null) {
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
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(), // Ícone de carregamento
              SizedBox(height: 16),
              Text("Aguarde..."), // Texto informativo
            ],
          ),
        );
      });

    // Crie uma solicitação Multipart
var request = http.MultipartRequest('POST', Uri.parse(url))
  ..headers['Authorization'] = 'Bearer $token'
  ..fields['novoEndereco'] = newAddress
  ..fields['novoTelefone'] = newPhone;

// Adicione o arquivo ao corpo da solicitação POST
if (fileBytes != null) {
  request.files.add(http.MultipartFile.fromBytes('arquivo', fileBytes, filename: 'documento.pdf'));
}

    // Envie a solicitação POST
    http.Response response = await http.Response.fromStream(await request.send());

    Navigator.pop(context); // Fecha o diálogo de carregamento
    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 201) {
      // Alteração bem-sucedida
      print('Solicitação POST bem-sucedida');
      print('Resposta: ${response.body}');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Solicitação enviada para análise."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    } else if (responseBody.containsKey('msg') == true) {
      // Tratamento para outros erros
      print('Falha na solicitação POST');
      print('Código de status: ${response.statusCode}');
      print('Resposta: ${response.body}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
              child: Text("Já existe uma petição em andamento, aguarde o resultado para fazer uma nova solicitação!", textAlign: TextAlign.center),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    } else if (responseBody.containsKey('msg') != true){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Ops, algo deu errado!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    }
  }
}

  
