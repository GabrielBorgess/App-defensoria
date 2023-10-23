import 'package:flutter/material.dart';
import 'change_data_screen.dart';
import '../widgets/header_home.dart';

class ProfilePage extends StatelessWidget {
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
                          "Bem Vindo(a)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/logoInformacoes.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                )
                              ],
                            ),
                            Image.asset('assets/seta.png'),
                          ],
                        ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeDataScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/logoInformacoes.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Alterar dados",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02)),
                                      Text("Endereço e Telefone",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Image.asset('assets/seta.png'),
                          ],
                        ),
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
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/iconInformativo.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Acessar informações",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02)),
                                      Text("Informações no site",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Image.asset('assets/seta.png'),
                          ],
                        ),
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
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/iconChatbot.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Chat Bot",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02)),
                                      Text("Tire suas dúvidas com o chat bot",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Image.asset('assets/seta.png'),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 1.5,
                            child: const DecoratedBox(
                                decoration:
                                    BoxDecoration(color: Colors.black12)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
