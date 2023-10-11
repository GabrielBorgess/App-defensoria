import 'package:flutter/material.dart';
import 'screens/profile.dart';
import 'screens/home_page.dart';
import 'screens/error_screen.dart';
import 'screens/primeiro_acesso.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seu App',
      color: Color.fromARGB(236, 224, 224, 224), // Define a cor principal aqui
      home: HomePage(),
      routes: {
        '/profile': (context) => ProfilePage(),
        '/tela_de_erro': (context) => ErrorScreen(),
        '/primeiro_acesso' : (context) => FirstAccess(),
        '/home': (context) => HomePage()
      },
    );
  }
}
