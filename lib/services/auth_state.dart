import 'package:flutter/widgets.dart';

class AuthState extends ChangeNotifier {
  String authToken;
  String resetToken;
  String userName;

  AuthState()
      : authToken = "",
        resetToken = "",
        userName = "";

  void setAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }
}
