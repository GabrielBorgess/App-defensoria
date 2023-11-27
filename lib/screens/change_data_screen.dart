import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/change_data.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

final TextEditingController _adressController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _bairroController = TextEditingController();
final TextEditingController _cepController = TextEditingController();
final TextEditingController _numeroController = TextEditingController();

String fileName = "";

Future<Map<String, String>> getCep(context, String cep) async {
  String url = 'https://viacep.com.br/ws/$cep/json/';

   http.Response response = await http.get(
    Uri.parse(url),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    print(responseBody);

    String logradouro = responseBody['logradouro'];
    String complemento = responseBody['complemento'];
    String bairroText = responseBody['bairro'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('logradouro', logradouro);
    await prefs.setString('complemento', complemento);
    await prefs.setString('bairro', bairroText);

    _adressController.text = logradouro;
    _bairroController.text = bairroText;

    return {
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairroText,
    };
  } else {
    return {
      'logradouro': '',
      'complemento': '',
      'bairro': '',
    };
  }
}

// ignore: must_be_immutable
class ChangeDataScreen extends StatefulWidget {
  ChangeDataScreen({Key? key}) : super(key: key);

  @override
  State<ChangeDataScreen> createState() => _ChangeDataScreenState();
}

class _ChangeDataScreenState extends State<ChangeDataScreen> {
  bool cepFunctionCalled = false;
  String bairroText = '';

  PlatformFile? objFile;
  Uint8List? fileBytes;

  void chooseFileUsingFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
      withReadStream: true,
    );

    if (result != null) {
      PlatformFile file = result.files.single;

      // Verificar se a extensão do arquivo é 'pdf'
      if (file.extension?.toLowerCase() == 'pdf') {
        final List<int> bytes = await File(file.path!).readAsBytes();
        setState(() {
          objFile = file;
          fileBytes = Uint8List.fromList(bytes);
          fileName = objFile!.name;
        });
      } else {
        // Exibir mensagem de erro
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Por favor, selecionar tipo de arquivo PDF."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void changeData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token') ?? "";

    final String newAddress =
        ('${_adressController.text.trim()} ${_bairroController.text.trim()} ${_numeroController.text.trim()} CEP: ${_cepController.text.trim()}');
    final String newPhone = _phoneController.text.trim();

    changeDataAuth(context, authToken, newAddress, newPhone, fileBytes);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cepController.addListener(() {
        if (_cepController.text.length == 8 && !cepFunctionCalled) {
          cepFunctionCalled = true;
          final String cep = _cepController.text.trim();
          getCep(context, cep);
        } else if (_cepController.text.length < 8) {
          cepFunctionCalled = false;
        }
      });
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              child: Image.asset(
                'assets/logoBonita.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31, right: 31),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Alterar Endereço",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("CEP"),
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                        controller: _cepController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Endereço"),
                      ),
                      TextFormField(
                        controller: _adressController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
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
                        controller: _bairroController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Complemento"),
                      ),
                      TextFormField(
                        controller: _numeroController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
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
                            width: 400,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () => chooseFileUsingFilePicker(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color.fromRGBO(33, 71, 22, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(fileName.isNotEmpty ? fileName : "+"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Número de celular"),
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
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
                        onPressed: () => {changeData(context)},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(33, 71, 22, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Enviar"),
                      ),
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
