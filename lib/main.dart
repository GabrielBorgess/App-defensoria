import 'package:defensoria/screens/policy_screen.dart';
import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/first_access_screen.dart';
import 'screens/reset_password_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        // Outros provedores podem ser adicionados aqui, se necessário.
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget principal da aplicação
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seu App',
      color: Color.fromARGB(236, 224, 224, 224),

      // Define a rota inicial e as rotas nomeadas
      home: LoginScreen(),
      routes: {
        '/profile': (context) => ProfilePage(),
        '/primeiro_acesso': (context) => FirstAccess(),
        '/home': (context) => LoginScreen(),
        '/policy': (context) => PrivacyPolicy(),
        '/resetpass': (context) => ResetPassword(),
        '/resetpass_auth': (context) => ResetPasswordAuth(),
      },
    );
  }
}
