import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seu App',
      color: Color.fromARGB(236, 224, 224, 224), // Define a cor principal aqui
      home: HomePage(),
    );
  }
}

class CustomButton {
  final String imagePath;
  final String url;

  CustomButton(this.imagePath, this.url);
}

List<CustomButton> buttonsList = [
  CustomButton("assets/atendimento.png",
      "https://www.defensoria.df.gov.br/?page_id=1429"),
  CustomButton("assets/documentosNecessarios.png",
      "https://www.defensoria.df.gov.br/?page_id=1448"),
  CustomButton("assets/enderecoTelefone.png",
      "https://www.defensoria.df.gov.br/?page_id=63141"),
  CustomButton("assets/defesaSaude.png",
      "https://www.defensoria.df.gov.br/?page_id=284"),
  CustomButton("assets/defesaMulher.png",
      "https://www.defensoria.df.gov.br/?page_id=311"),
  CustomButton("assets/segundograuTribunais.png",
      "https://www.defensoria.df.gov.br/?page_id=414"),
  CustomButton("assets/infanciaeJuventude.png",
      "https://www.defensoria.df.gov.br/?page_id=331"),
  CustomButton("assets/nucleoExecucaoPenais.png",
      "https://www.defensoria.df.gov.br/?page_id=373"),
  CustomButton("assets/medidasSocioeducativas.png",
      "https://www.defensoria.df.gov.br/?page_id=404"),
  CustomButton("assets/defesaIdoso.png",
      "https://www.defensoria.df.gov.br/?page_id=386"),
  CustomButton("assets/forumMirabete.png",
      "https://www.defensoria.df.gov.br/?page_id=424"),
  CustomButton("assets/direitosHumanos.png",
      "https://www.defensoria.df.gov.br/?page_id=320"),
  CustomButton("assets/custodiaPresos.png",
      "https://www.defensoria.df.gov.br/?page_id=363"),
  CustomButton("assets/nucleoMeditacao.png",
      "https://www.defensoria.df.gov.br/?page_id=354"),
  CustomButton(
      "assets/consumidor.png", "https://www.defensoria.df.gov.br/?page_id=299"),
  CustomButton("assets/fazendaPublica.png",
      "https://www.defensoria.df.gov.br/?page_id=395"),
  // Adicione mais objetos CustomButton conforme necessário
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderHome(),
            Column(),
          ],
        ),
      ),
    );
  }
}

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 50.0,
          bottom: 76.0,
        ),
        child: Image.asset('assets/logoBonita.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.22));
  }
}
