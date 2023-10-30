import 'package:flutter/widgets.dart';

class AuthState extends ChangeNotifier {
  String authToken;
  String resetToken;
  String userName;
  String peticaoData;
  String peticaoStatus;
  String peticaoTipo;

  AuthState()
      : authToken = "",
        resetToken = "",
        userName = "",
        peticaoData = "",
        peticaoStatus = "",
        peticaoTipo = "";

  void setAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }
}
