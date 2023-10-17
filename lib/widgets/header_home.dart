import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logoBonita.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.22);
  }
}