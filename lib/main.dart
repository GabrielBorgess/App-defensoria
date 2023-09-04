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
            Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 42, 78, 58),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 130),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 22,
                      crossAxisSpacing: 22,
                    ),
                    padding: EdgeInsets.all(18),
                    itemCount: buttonsList.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(buttonsList[index].url),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 128, 55),
                            textStyle: TextStyle(fontSize: 18.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Image.asset(
                                buttonsList[index].imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ),
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
        left: 32.0,
        right: 32.0,
        top: 44.0,
        bottom: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset('assets/logoBonita.png')),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.55,
            child: Ink(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 42, 78, 58),
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () => {},
                child: Center(
                    child: Text(
                  "ÁREA DO ASSISTIDO",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}