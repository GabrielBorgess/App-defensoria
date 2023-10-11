import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/header_home.dart';
import '../services/post.dart';
import '../services/create_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Post?>? post;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _context = context; // Atribui o contexto à variável local
    _checkAuthAndNavigate(); // Chame a função na inicialização da tela
  }

  void clickPostButton() {
    final String cpf = _cpfController.text.trim();
    final String senha = _senhaController.text.trim();

    // Agora você pode usar 'cpf' e 'senha' como desejar, por exemplo, passando para a função createPost
    setState(() {
      post = createPost(context, cpf, senha) as Future<Post?>?;
    });
  }

  void _checkAuthAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    final loginTimestamp = prefs.getInt('login_timestamp');

    if (authToken != null && loginTimestamp != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final elapsedSeconds = (currentTime - loginTimestamp) ~/ 1000;
      if (elapsedSeconds > 60) {
        // O usuário ainda está autenticado, então vá para a página de perfil
        prefs.remove('auth_token');
        Navigator.pushReplacementNamed(_context, '/home'); // Use a variável local
      } else {
        // O tempo de inatividade expirou, faça logout automaticamente
        prefs.remove('auth_token');
        Navigator.pushReplacementNamed(_context, '/login'); // Use a variável local
      }
    }
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
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          "Acesse sua conta",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _cpfController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "CPF",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          obscureText: true,
                          controller: _senhaController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "Senha",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () => clickPostButton(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(33, 71, 22, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text("Acessar"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color.fromRGBO(33, 71, 22, 1)),
                                  borderRadius: BorderRadius.circular(8))),
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
