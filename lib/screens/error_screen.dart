import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 31, right: 31),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Logo', style: TextStyle(fontSize: 70),),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 53, bottom:12),
                    child: Text("Oops, Desculpe!!", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.028),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Text("Parece que ocorreu algum erro, estamos nos esforçando para melhorar", textAlign: TextAlign.center,),
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(33, 71, 22, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text("Voltar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}