import '../widgets/header_home.dart';
import 'package:flutter/material.dart';
import '../services/reset_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';

//--- Verificar se cpf existe e enviar primeira requisição

final TextEditingController _cpfController = TextEditingController();

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
                          "Digite seu CPF",
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
                            onPressed: () => cpfSearchForReset(context),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(33, 71, 22, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text("Acessar"),
                          ),
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

void cpfSearchForReset(BuildContext context) {
  final String cpf = _cpfController.text.trim();
  cpfSearchReset(context, cpf);
}

//--- Fim da verificação do cpf

//--- Validar codigo do SMS e trocar senha
final TextEditingController _emailCodeController = TextEditingController();
final TextEditingController _newPass1 = TextEditingController();
final TextEditingController _newPass2 = TextEditingController();


class ResetPasswordAuth extends StatefulWidget {
  const ResetPasswordAuth({super.key});

  @override
  State<ResetPasswordAuth> createState() => _ResetPasswordAuthState();
}

class _ResetPasswordAuthState extends State<ResetPasswordAuth> {

void forgotPass(context) async {
  final String emailCode = _emailCodeController.text.trim();
  final String newpass1 = _newPass1.text.trim();
  final String newPass2 = _newPass2.text.trim();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final resetToken = prefs.getString('reset_token') ?? "";

  resetPassAuth(context, resetToken, emailCode, newpass1, newPass2);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 60),
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
                          "Digite o código recebido no seu e-mail:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _emailCodeController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "Código de 4 digitos",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          "Digite sua nova senha:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _newPass1,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                          color: Colors.black,
                        ),  
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "senha nova",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _newPass2,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                          color: Colors.black,
                        ),  
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "confirmar senha nova",
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
                            onPressed: () => forgotPass(context),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(33, 71, 22, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text("Resetar sua senha"),
                          ),
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

