import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:users/editarUsuario.dart';

class ListarUsuarios extends StatefulWidget {
  const ListarUsuarios({super.key});

  @override
  State<ListarUsuarios> createState() => _ListarUsuariosState();
}

class _ListarUsuariosState extends State<ListarUsuarios> {
  List<dynamic> data = []; //almacenar los datos obtenidos de la api
  List<dynamic> resultados = []; //almacenar los resultados de la búsqueda
  final documentoBuscar = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    final response = await http
        .get(Uri.parse('https://api-usuario-2oqx.onrender.com/api/usuario'));

    //si es 200 es porque todo esta bien
    if (response.statusCode == 200) {
      Map<String, dynamic> decodeData = json.decode(response.body);

      setState(() {
        data = decodeData['usuarios'] ?? [];
        print(data);
      });
    } else {
      print('Revisar el código, existen fallos ${response.statusCode}');
    }
  }

  void buscarUsuario() {
    final String documentoBuscado = documentoBuscar.text;

    setState(() {
      resultados = data
          .where(
              (usuario) => usuario['documento'].toString() == documentoBuscado)
          .toList();
    });
  }

  void editarUsuario(int index) {
    // Navega a la pantalla EditarUsuario con los datos del usuario
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarUsuario(
          usuario: resultados.length > 0 ? resultados[index] : data[index],
        ),
      ),
    );
  }

  void eliminarUsuario(int index) async {
    final String idUsuario =
        resultados.length > 0 ? resultados[index]['_id'] : data[index]['_id'];

    try {
      final response = await http.delete(
        Uri.parse('https://api-usuario-2oqx.onrender.com/api/usuario'),
        body: jsonEncode({'_id': idUsuario}),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          resultados.removeAt(index);
          data.removeWhere((user) => user['_id'] == idUsuario);
        });

        print('Usuario eliminado exitosamente');
      } else {
        print('Revisar el código, existen fallos ${response.statusCode}');
      }
    } catch (error) {
      print('Error al eliminar el usuario: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formUsuario = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 1, 158),
        title: const Text('Listar Usuarios'),
      ),
      body: Form(
        child: Column(
          children: [
            Card(
              elevation: 2,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formUsuario,
                  child: Column(
                    children: [
                      const Text('Buscar Usuarios',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: documentoBuscar,
                        decoration: const InputDecoration(
                          labelText: 'Documento',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return 'Este campo es requerido';
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!formUsuario.currentState!.validate()) {
                              print('Formulario no valido');
                              return;
                            }
                            buscarUsuario();
                          },
                          child: const Text('Buscar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    resultados.length > 0 ? resultados.length : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Documento: ${resultados.length > 0 ? resultados[index]['documento'] : data[index]['documento']}"),
                          Text(
                              "Nombre: ${resultados.length > 0 ? resultados[index]['nombre'] : data[index]['nombre']}"),
                          Text(
                              "Dirección: ${resultados.length > 0 ? resultados[index]['direccion'] : data[index]['direccion']}"),
                          Text(
                              "Teléfono: ${resultados.length > 0 ? resultados[index]['telefono'] : data[index]['telefono']}"),
                          Text(
                              "Correo: ${resultados.length > 0 ? resultados[index]['correo'] : data[index]['correo']}"),
                          Text(
                              "Estado: ${resultados.length > 0 ? resultados[index]['estado'] : data[index]['estado']}"),
                          Text(
                              "ID Rol: ${resultados.length > 0 ? resultados[index]['idRol'] : data[index]['idRol']}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              editarUsuario(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar eliminación'),
                                    content: const Text(
                                        '¿Estás seguro de que quieres eliminar este usuario?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          eliminarUsuario(index);
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ListarUsuarios()));
                                        },
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
