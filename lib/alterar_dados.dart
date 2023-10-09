import 'package:flutter/material.dart';



class AlterarDados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              child: Image.asset('assets/logoBonita.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.14),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31, right: 31),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text("Alterar Endereço", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.04),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("Endereço"),
                      ),
                      TextFormField(
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Bairro"),
                      ),
                      TextFormField(
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Número"),
                      ),
                      TextFormField(
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("CEP"),
                      ),
                      TextFormField(
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Text("Enviar comprovante de residência (PDF)"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 10),
                          child: SizedBox(
                          width: 71,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              // -------------- FUNÇÃO PARA LEVAR PARA OUTRA PÁGINA ---------
                              },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, textStyle: const TextStyle(fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(33, 71, 22, 1)),borderRadius: BorderRadius.circular(8))
                              ), 
                            child: Text("+"),                        
                            ),
                          ),
                        ),
                        Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Número de celular 1"),
                      ),
                      TextFormField(
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Número de celular 2"),
                      ),
                      TextFormField(
                            decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black) ,borderRadius: BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ],
                  ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 44, top: 30),
                          child: SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(33, 71, 22, 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                              ),
                              child: Text("Enviar"),                        
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}