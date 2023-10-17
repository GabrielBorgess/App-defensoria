import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/error_screen.dart';
import 'screens/first_access_screen.dart';
import 'screens/reset_password_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        // Outros Providers, se houver
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seu App',
      color: Color.fromARGB(236, 224, 224, 224), // Define a cor principal aqui
      home: LoginScreen(),
      routes: {
        '/profile': (context) => ProfilePage(),
        '/error_screen': (context) => ErrorScreen(),
        '/primeiro_acesso': (context) => FirstAccess(),
        '/home': (context) => LoginScreen(),
        '/resetpass': (context) => ResetPassword(),
        '/resetpass_auth': (context) => ResetPasswordAuth(),
      },
    );
  }
}
