import '../widgets/header_home.dart';
import 'package:flutter/material.dart';
import '../services/login.dart';
import 'package:provider/provider.dart';
import '../services/auth_state.dart';

class FirstAccess extends StatelessWidget {
  const FirstAccess({super.key});

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
                          "Configure sua senha",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _novaSenhaController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "Nova senha",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _novaSenhaAgainController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "Repita a senha",
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

void clickPostButton(BuildContext context) {
  final String senha1 = _novaSenhaController.text.trim();
  //final String senha2 = _novaSenhaAgainController.text.trim();

  final authToken = context.read<AuthState>().authToken;

  // _checkAuthAndNavigate();
  resetFirstLoginPass(context, senha1, authToken);
}

final TextEditingController _novaSenhaController = TextEditingController();
final TextEditingController _novaSenhaAgainController = TextEditingController();
