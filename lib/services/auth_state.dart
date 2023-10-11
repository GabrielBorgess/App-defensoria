import 'package:flutter/widgets.dart';

class AuthState extends ChangeNotifier {
  String authToken;

  AuthState() : authToken = "";

  void setAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }
}
