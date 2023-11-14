import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/change_data.dart';
import 'package:file_picker/file_picker.dart';

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
    
  }}
// ignore: must_be_immutable
class ChangeDataScreen extends StatefulWidget {
  ChangeDataScreen({Key? key}) : super(key: key);

  @override
  State<ChangeDataScreen> createState() => _ChangeDataScreenState();
}

class _ChangeDataScreenState extends State<ChangeDataScreen> {
  bool cepFunctionCalled = false;

  String bairroText = '';

  //  List<PlatformFile>? _paths;

  // void pickFiles() async {
  //   try {
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowMultiple: false,
  //       onFileLoading: (FilePickerStatus status) => print(status),
  //       allowedExtensions: ['png', 'jpg', 'jpeg', 'heic', 'pdf'],
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     log('Unsupported operation$e');
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   setState(() {
  //     if (_paths != null) {
  //       if (_paths != null) {
  //         //passing file bytes and file name for API call
  //         ApiClient.uploadFile(_paths!.first.bytes!, _paths!.first.name);
  //       }
  //     }
  //   });
  // }
   PlatformFile? objFile;

void chooseFileUsingFilePicker() async {
  var result = await FilePicker.platform.pickFiles(
    withReadStream: true,
  );
  if (result != null) {
    setState(() {
      objFile = result.files.single;
      fileName = objFile!.name;
    });
  }
}


  void uploadSelectedFile() async {
    //---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("Your API URL"),
    );
    //-----add other fields if needed
    request.fields["id"] = "abc";

    //-----add selected file with request
request.files.add(http.MultipartFile(
    "Your parameter name on server side", objFile!.readStream ?? Stream.empty(), objFile!.size,
    filename: objFile!.name));


    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
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
                        onPressed: () => {changeData(context), uploadSelectedFile()},
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

      
void changeData(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final authToken = prefs.getString('auth_token') ?? "";

  final String newAdress = ('${_adressController.text.trim()} ${_bairroController.text.trim()} ${_numeroController.text.trim()} CEP: ${_cepController.text.trim()}'
  );
  final String newPhone = _phoneController.text.trim();

  changeDataAuth(context, authToken, newAdress, newPhone);

}

