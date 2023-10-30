import 'package:flutter/material.dart';
import '../widgets/header_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SolicitationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                              )    
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FutureBuilder<PeticaoData>(
                            future: getPeticao(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              PeticaoData peticaoData = snapshot.data!;
                              String peticaoTipo = peticaoData.tipo;
                              String peticaoData1 = peticaoData.data;
                              String peticaoStatus = peticaoData.status;
                              return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(peticaoTipo,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(peticaoData1,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018))
                                ],
                              ),
                            ); 
                            } else {
                             return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Minhas solicitações",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text("Acompanhar solicitações",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018))
                                  ],
                                ),
                              );
                            }
                          } 
                         )
                        ],
                      ),
                      Image.asset('assets/seta.png'),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 1.5,
                        child: const DecoratedBox(
                            decoration:
                                BoxDecoration(color: Colors.black12)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Future<PeticaoData> getPeticao() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final peticaoData = prefs.getString('DataPeticao') ?? "";
  final peticaoStatus = prefs.getString('Status') ?? "";
  final peticaoTipo = prefs.getString('Tipo') ?? "";

  print(peticaoStatus);
  print(peticaoTipo);
  print(peticaoData);

  return PeticaoData(status: peticaoStatus, tipo: peticaoTipo, data: peticaoData);
}

}
   class PeticaoData {
  final String status;
  final String tipo;
  final String data;

  PeticaoData({required this.status, required this.tipo, required this.data});
}
