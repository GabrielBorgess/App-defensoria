import 'package:flutter/material.dart';
import '../widgets/header_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PeticaoData {
  final String status;
  final String tipo;
  final String data;
  final String obs;

  PeticaoData({required this.status, required this.tipo, required this.data, required this.obs});
}
class SolicitationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.height * 2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55, bottom: 45),
                child: HeaderHome(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 31,
                  right: 31,
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 44),
                          child: Text(
                            "Minhas Solicitações",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<List<PeticaoData>?>(
                    future: getPeticoes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erro: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                        return Text("Nenhuma petição encontrada");
                      } else {
                        List<PeticaoData> peticoes = snapshot.data!;
                          return Column(
                             children: peticoes.map((peticao) {
          String peticaoStatus = peticao.status;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              peticao.tipo,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    MediaQuery.of(context).size.height * 0.02,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.height * 0.35,
                                                    child: RichText(
                                                              text: TextSpan(
                                                                text: 'Observação: ${peticao.obs}',
                                                                style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                        ),
                                                      ),
                                                    softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              peticao.data,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                              ),
                                            ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                   Padding(
                                     padding: const EdgeInsets.only(top:8.0),
                                     child: Container(
                                                     decoration: BoxDecoration(
                                                       color: (peticaoStatus == '0'
                                                                       ? Colors.yellow[800]
                                                                       : peticaoStatus == '1'
                                                   ? Colors.green[800]
                                                   : Colors.red[800]),
                                                       borderRadius: BorderRadius.all(Radius.circular(8)),
                                                     ),
                                                     width: MediaQuery.of(context).size.width * 0.2,
                                                     height: MediaQuery.of(context).size.height * 0.03,
                                                     child: Center(
                                                       child: Text(
                                                         peticaoStatus == '0' ? 'em Análise' : (peticaoStatus == '1' ? 'Aceito' : 'Rejeitado'),
                                                         style: TextStyle(
                                                                   color: Colors.white,
                                                                   fontWeight: FontWeight.w400,
                                                                   fontSize: MediaQuery.of(context).size.height * 0.017,
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                   ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12, bottom: 20),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 1.5,
                                      child: const DecoratedBox(
                                        decoration: BoxDecoration(color: Colors.black12),
                                      ),
                                    ),
                                  ), 
                                ],
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Future<List<PeticaoData>> getPeticoes() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> peticaoStatusList = prefs.getStringList('Status') ?? [];
  final List<String> peticaoTipoList = prefs.getStringList('Tipo') ?? [];
  final List<String> peticaoDataList = prefs.getStringList('DataPeticao') ?? [];
  final List<String> peticaoObsList = prefs.getStringList('Observacao') ?? [];

  List<PeticaoData> peticoes = [];

  for (int i = 0; i < peticaoStatusList.length; i++) {
    PeticaoData peticao = PeticaoData(
      status: peticaoStatusList[i],
      tipo: peticaoTipoList[i],
      data: peticaoDataList[i],
      obs: peticaoObsList[i],
    );
    peticoes.insert(0,peticao);
  }

  return peticoes;
}

}