import 'package:flutter/widgets.dart';

class AuthState extends ChangeNotifier {
  String authToken;
  String resetToken;

  AuthState()
      : authToken = "",
        resetToken = "";

  void setAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }
}
