import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/header_home.dart';
import '../services/login.dart';
import 'package:provider/provider.dart';
import '../services/auth_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void clickPostButton(BuildContext context) async { 

    final String cpf = _cpfController.text.trim();
    final String senha = _senhaController.text.trim();
    final String cpfNovo = maskCpf(cpf);
    login(context, cpfNovo, senha).then((authToken) {
      context.read<AuthState>().setAuthToken(authToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Column(
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
                          inputFormatters: [CPFMask()],
                            controller: _cpfController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black 
                                      ),
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                labelText: "CPF",
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            obscureText: true,
                            controller: _senhaController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                labelText: "Senha",
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
                              onPressed: () => clickPostButton(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(33, 71, 22, 1),
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
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/resetpass'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
          );
        }),
      ),
    );
  }
}

//  Validação de espaços, validação de cpf, alteração de pontos e traços

class CPFMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (RegExp(r'[^\d-.]+').hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}

String maskCpf(String cpf) {
  var cpfNovo = "";

  for (var i = 0; i < cpf.length; i++) {
    if ((cpf[i] != ".") && (cpf[i] != "-")) {
      cpfNovo += cpf[i];
    }
  }
  return cpfNovo;
}