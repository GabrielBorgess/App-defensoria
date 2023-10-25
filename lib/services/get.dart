import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


Future<String> getName(context, String cpf, String token) async {
  String url = 'http://172.88.0.224:3000/assistido/perfil';

  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };

  print('so pra ter certeza: $token');

   http.Response response = await http.get(
    Uri.parse(url),
    headers: headers,
  );


  if (response.statusCode == 201) {
    final Map<String, dynamic> responseBody = json.decode(response.body);

    String userName = responseBody['nome'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', userName);

    print('Resposta: ${response.body}');
    print('PEGAMOS O NOME!!!');
    print('Nome: $userName');

    return userName;
  } else {
    print('Falha na solicitação POST');
    print('Código de status: ${response.statusCode}');
    print('Resposta: ${response.body}');
    return '';
  }
}