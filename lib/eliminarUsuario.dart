import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

class EliminarUsuario extends StatefulWidget {
  const EliminarUsuario({super.key});

  @override
  State<EliminarUsuario> createState() => _EliminarUsuarioState();
}

class _EliminarUsuarioState extends State<EliminarUsuario> {
  final id = TextEditingController();

  @override
  void initState() {
    super.initState();
    deleteUsuario();
  }

  Future<void> deleteUsuario() async {
    final response = await http.delete(
      Uri.parse('https://api-usuario-2oqx.onrender.com/api/usuario'),
      body: jsonEncode({'_id': id.text}),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );
    // si es 200 es porque todo esta bien
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      print('Revisar el codigo existen fallos ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formUsuario = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 1, 158),
        title: const Text('Eliminar Usuario'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
        child: Form(
          key: formUsuario,
          child: Column(
            children: [
               const Card(
  elevation: 2,
  margin: EdgeInsets.all(50),
  child: Padding(
    padding: EdgeInsets.all(20.0),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text('Eliminar Usuario'),
    ),
  ),
),
              TextFormField(
                  controller: id,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('ID'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (!formUsuario.currentState!.validate()) {
                        print('Formulario no valido');
                        return;
                      } else {
                        AwesomeDialog(
                          context: context,
                          keyboardAware: true,
                          dismissOnBackKeyPress: false,
                          dialogType: DialogType.warning,
                          animType: AnimType.bottomSlide,
                          btnCancelText: "Cancelar",
                          btnOkText: "Aceptar",
                          title: 'Eliminar Usuario?',
                          // padding: const EdgeInsets.all(5.0),

                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                      deleteUsuario();
                    },
                    child: const Text('Eliminar')),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
