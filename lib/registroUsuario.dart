import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  List<String> usuarios = [];
  final documento = TextEditingController();
  final nombre = TextEditingController();
  final direccion = TextEditingController();
  final telefono = TextEditingController();
  final correo = TextEditingController();
  final estado = TextEditingController();
  final idRol = TextEditingController(text: 'Administrador');

  @override
  void initState() {
    super.initState();
    postUsuarios();
  }

  Future<void> postUsuarios() async {
    final response = await http.post(
      Uri.parse('https://api-usuario-2oqx.onrender.com/api/usuario'),
      body: jsonEncode({
        'documento': documento.text,
        'nombre': nombre.text,
        'direccion': direccion.text,
        'telefono': telefono.text,
        'correo': correo.text,
        'estado': estado.text,
        'idRol': '6508716fcac526cc61bfe45e'
      }),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );
    // si es 200 es porque todo esta bien
    if (response.statusCode == 200) {
      setState(() {});
    } else {
      print('Revisar el codigo existen fallos ${response.statusCode}');
    }
  }

  Future<void> LimpiezaForm() async {
    documento.clear();
    nombre.clear();
    direccion.clear();
    telefono.clear();
    correo.clear();
    correo.clear();
    estado.clear();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formUsuario = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 1, 158),
        title: const Text('Registrar Usuarios'),
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
                    child: Text('Registrar Usuario'),
                  ),
                ),
              ),
              TextFormField(
                  controller: documento,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Documento'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  }),
              TextFormField(
                  controller: nombre,
                  decoration: const InputDecoration(label: Text('Nombre')),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  }),
              TextFormField(
                  controller: direccion,
                  decoration: const InputDecoration(label: Text('Direccion')),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  }),
              TextFormField(
                  controller: telefono,
                  decoration: const InputDecoration(label: Text('Telefono')),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  }),
              TextFormField(
                  controller: correo,
                  decoration: const InputDecoration(label: Text('Correo')),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  }),
              TextFormField(
                  controller: estado,
                  decoration: const InputDecoration(label: Text('Estado')),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  }),
              TextFormField(
                  controller: idRol,
                  readOnly: true,
                  decoration: const InputDecoration(label: Text('Rol')),
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
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          dialogType: DialogType.success,
                          showCloseIcon: true,
                          title: 'Confirmado',
                          desc: 'Usuario registrado con exito',
                          btnOkOnPress: () {
                            debugPrint('OnClcik');
                          },
                          btnOkIcon: Icons.check_circle,
                          onDismissCallback: (type) {
                            debugPrint('Dialog Dissmiss from callback $type');
                          },
                        ).show();
                      }
                      postUsuarios();
                      LimpiezaForm();
                    },
                    child: const Text('Registrar')),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
