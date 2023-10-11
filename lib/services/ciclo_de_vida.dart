import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLifecycleManager extends WidgetsBindingObserver {
  final BuildContext context;

  AppLifecycleManager(this.context);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAuthAndNavigate();
    }
  }

  void _checkAuthAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    final loginTimestamp = prefs.getInt('login_timestamp');

    if (authToken != null && loginTimestamp != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final elapsedMinutes = (currentTime - loginTimestamp) ~/ (1000 * 60);
      if (elapsedMinutes > 5) {
        // O tempo de inatividade expirou, faça logout automaticamente
        prefs.remove('auth_token');
        Navigator.pushReplacementNamed(
            context, '/login'); // Redirecione para a tela de login
      }
    }
  }
}
