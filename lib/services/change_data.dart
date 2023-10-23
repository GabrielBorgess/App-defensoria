import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> changeDataAuth(context, String token, String newAddress, String newPhone) async {
  String url = 'http://172.88.0.224:3000/assistido/alterarDados';

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
    },
  );

  // Realiza a solicitação POST
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {"novoEndereco": newAddress, "novoTelefone": newPhone},
  );

  Navigator.pop(context); // Fecha o diálogo de carregamento

  if (response.statusCode == 201) {
    // Alteração bem-sucedida
    print('Solicitação POST bem-sucedida');
    print('Resposta: ${response.body}');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Alteração bem-sucedida"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/profile');
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  } else if (response.statusCode == 500) {
    // Tratamento para erro 500
    Navigator.pushReplacementNamed(context, '/error_screen');
  } else {
    // Tratamento para outros erros
    print('Falha na solicitação POST');
    print('Código de status: ${response.statusCode}');
    print('Resposta: ${response.body}');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Falha na alteração. Tente novamente mais tarde."),
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
