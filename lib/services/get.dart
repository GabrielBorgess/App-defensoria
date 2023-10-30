import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


Future<String> getName(context, String cpf, String token) async {
  String url = 'http://172.88.0.224:3000/assistido/perfil';

  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };

   http.Response response = await http.get(
    Uri.parse(url),
    headers: headers,
  );

if (response.statusCode == 201) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    
    if (responseBody.containsKey('DadosUser')) {
      final Map<String, dynamic> dadosUser = responseBody['DadosUser'];
      String userName = dadosUser['nome'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', userName);

      if (responseBody.containsKey('DadosPeticao')) {
        final List<dynamic> dadosPeticao = responseBody['DadosPeticao'];
        if (dadosPeticao.isEmpty) {
          // "DadosPeticao" é um array vazio
          // Lide com a situação em que não há petições
          print('Sem petições disponíveis');
        } else {
          // "DadosPeticao" contém petições, você pode acessá-las aqui
          for (var peticao in dadosPeticao) {
            String peticaoTipo = peticao['Tipo'];
            String peticaoData = peticao['DataPeticao'];
            String peticaoStatus = peticao['Status'];
            print('Tipo de Petição: $peticaoTipo');
            print('Data da Petição: $peticaoData');
            print('Status da Petição: $peticaoStatus');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('Tipo', peticaoTipo);

            await prefs.setString('DataPeticao', peticaoData);

            await prefs.setString('Status', peticaoStatus);
          }
        }
      }
      
      return userName;
    } else {
      print('Falha na solicitação POST');
      print('Código de status: ${response.statusCode}');
      print('Resposta: ${response.body}');
      return '';
    }
  }
  
  return '';
}


