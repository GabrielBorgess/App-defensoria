import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post.dart';

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
      routes: {
        '/home': (context) => ProfilePage(),
      },
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

Future<Post> createPost(String cpf, String senha) async {
  Map<String, dynamic> request = {
    'cpf': cpf,
    'senha': senha
  };

  print(request);

  final uri = Uri.parse("http://172.88.1.117:3000/entrar");
  print('Enviando solicitação POST para: $uri'); // Mensagem de depuração
  final response = await http.post(uri, body: request);

  if (response.statusCode == 200) {
    print('Resposta da API: ${response.statusCode} ${response.reasonPhrase}'); // Mensagem de depuração
    print('Corpo da resposta: ${response.body}'); // Mensagem de depuração
    return Post.fromJson(json.decode(response.body));

  } else {
    print('Erro na solicitação POST: ${response.statusCode} ${response.body}'); // Mensagem de depuração
    throw Exception('Failed to load post');
  }

}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Post?>? post;

  void clickPostButton() {
  final String cpf = _cpfController.text.trim();
  final String senha = _senhaController.text.trim();

  // Agora você pode usar 'cpf' e 'senha' como desejar, por exemplo, passando para a função createPost
  setState(() {
    post = createPost(cpf, senha);
  });
  }

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 114),
              child: HeaderHome(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 31,
                right: 31,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16
                        ),
                        child: Text("Acesse sua conta",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10
                        ),
                        child: TextFormField(
                          controller: _cpfController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                            hintText: "CPF",
                            hintStyle: TextStyle(color: Colors.black)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10
                        ),
                        child: TextFormField(
                          controller: _senhaController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                            hintText: "Senha",
                            hintStyle: TextStyle(color: Colors.black)
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          bottom: 8
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () => clickPostButton(),
                            
                            style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(33, 71, 22, 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                            ),
                            child: Text("Acessar"),                        
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () {
                            // -------------- FUNÇÃO PARA LEVAR PARA OUTRA PÁGINA ---------
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(33, 71, 22, 1)),borderRadius: BorderRadius.circular(8))
                          ), 
                          child: Text("Esqueci minha senha"),                        
                        ),
                      ),
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

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logoBonita.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.22);
  }
}

