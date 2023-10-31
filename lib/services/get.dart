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
    
      if (responseBody.containsKey('DadosPeticao')) {
    final List<dynamic> dadosPeticao = responseBody['DadosPeticao'];
    if (dadosPeticao.isEmpty) {
      // "DadosPeticao" é um array vazio
      // Lide com a situação em que não há petições
      print('Sem petições disponíveis');
    } else {
      // "DadosPeticao" contém petições, você pode acessá-las aqui
      List<String> peticaoTipoList = [];
      List<String> peticaoDataList = [];
      List<String> peticaoStatusList = [];



      for (var peticao in dadosPeticao) {
        String peticaoTipo = peticao['Tipo'];
        String peticaoData = peticao['DataPeticao'];
        int peticaoStatus = peticao['Status'];

        print(peticaoTipo);

        peticaoTipoList.add(peticaoTipo);
        peticaoDataList.add(peticaoData);
        peticaoStatusList.add(peticaoStatus.toString());
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('Tipo', peticaoTipoList);
      await prefs.setStringList('DataPeticao', peticaoDataList);
      await prefs.setStringList('Status', peticaoStatusList);
    }
  }
      
      return '';
    } else {
      print('Falha na solicitação POST');
      print('Código de status: ${response.statusCode}');
      print('Resposta: ${response.body}');
      return '';
    }
  }
  


