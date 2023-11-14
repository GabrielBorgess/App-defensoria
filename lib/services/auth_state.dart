import 'package:flutter/widgets.dart';

class AuthState extends ChangeNotifier {
  String authToken;
  String resetToken;
  String userName;
  String peticaoData;
  String peticaoStatus;
  String peticaoTipo;
  String logradouro;
  String complemento;
  String bairro;

  AuthState()
      : authToken = "",
        resetToken = "",
        userName = "",
        peticaoData = "",
        peticaoStatus = "",
        peticaoTipo = "",
        logradouro = "",
        complemento = "",
        bairro = "";
        

  void setAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }
}
