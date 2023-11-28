import 'package:flutter/material.dart';
import 'package:users/menu.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

class Acceso extends StatefulWidget {
  const Acceso({Key? key}) : super(key: key);

  @override
  State<Acceso> createState() => _AccesoState();
}

class _AccesoState extends State<Acceso> {
  final nombre = TextEditingController();
  final documento = TextEditingController();
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    final response = await http
        .get(Uri.parse('https://api-usuario-2oqx.onrender.com/api/usuario'));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodeData = json.decode(response.body);

      setState(() {
        data = decodeData['usuarios'] ?? [];
        print(data);
      });
    } else {
      print('Revisar el codigo existen fallos ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        
        body: SingleChildScrollView(
          child: Padding(
            
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            child: Column(
              
              children: [
                TextFormField(
                  controller: documento,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: const InputDecoration(labelText: 'Documento'),
                ),

                TextFormField(
                  controller: nombre,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      validarAcceso();
                    },
                    child: const Text('Acceso'),
                  ),
                  
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validarAcceso() {
    bool usuarioEncontrado = false;

    for (var usuario in data) {
      if (usuario['nombre'] == nombre.text &&
          usuario['documento'] == documento.text) {
        AwesomeDialog(
          context: context,
          animType: AnimType.leftSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: true,
          title: 'Usuario Correcto',
          desc: 'Bienvenido al sistema.',
          btnOkOnPress: () {
            debugPrint('OnClcik');
          },
          btnOkIcon: Icons.check_circle,
          onDismissCallback: (type) {
            debugPrint('Dialog Dissmiss from callback $type');
          },
        ).show();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Menu()),
        );
        usuarioEncontrado = true;

        return;
      }
    }
    if (!usuarioEncontrado) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Usuario no encontrado',
        desc: 'Documento o usuario invalido. Verifique su respuesta.',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }
  }
}
