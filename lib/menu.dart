import 'package:flutter/material.dart';
//import 'package:users/acceso.dart';
import 'package:users/editarUsuario.dart';
import 'package:users/eliminarUsuario.dart';
import 'package:users/listarUsuarios.dart';
import 'registroUsuario.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isDarkMode = false;
  int currentPageIndex = 0;

  Widget servicios() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1000,
            height: 500,
            child: Image.network(
                'https://static.vecteezy.com/system/resources/previews/007/414/845/non_2x/sport-motorcycle-logo-free-vector.jpg'),
          ),
          const Card(
            elevation: 50,
            margin: EdgeInsets.all(2),
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    'Mantenimiento Preventivo',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'El mantenimiento preventivo de la moto es una excelente tarea para realizar antes de salir de paseo y comprobar que todo marcha bien con nuestra motocicleta. Esta rutina consiste en revisar los aspectos más importantes de la moto para comprobar que no corremos ningún riesgo al conducirla',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 1000,
            height: 500,
            child: Image.network(
                'https://yt3.googleusercontent.com/OjQH5vrtQXofMUk7UFGeOAMNRBI1hFtj5o4OotwUul2UojPEnVbJgMfoo8FeufAwjkm927VEww=s900-c-k-c0x00ffffff-no-rj'),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                hoverColor: Colors.black,
                onPressed: () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
                child: const Icon(Icons.dark_mode),
              ),
            ),
          ),
          const Card(
            elevation: 50,
            margin: EdgeInsets.all(2),
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    'Mantenimiento Correctivo',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'El mantenimiento correctivo implica detener la operatividad de tu moto para poder repararla. Por ejemplo, es posible que percibas sonidos o vibraciones anormales en tu moto. Este tipo de mantenimiento te lleva a revisar el origen de la anomalía, lo que casi siempre implica un reemplazo de piezas.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 1000,
            height: 500,
            child: Image.network(
                'https://elements-cover-images-0.imgix.net/7c6105ac-1732-4ccf-b268-4a400ef4fec2?auto=compress%2Cformat&w=900&fit=max&s=2f0fc7a7826a09c308755a8dc74c9e27'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 1, 158),
          title: const Text('Motors Up - Usuarios'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 64,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 11, 16, 116),
                    ),
                    child: Image(
                      image: AssetImage('imagenes/moto.png'),
                      height: 1000,
                      width: 1000,
                    )),
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Registrar Usuarios'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistroUsuario()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.people_alt),
                title: const Text('Listar Usuarios'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListarUsuarios()));
                },
              ),
              const SizedBox(
                height: 350,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar Sesion'),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
              ),
            ],
          ),
        ),
        body: servicios(),
      ),
    );
  }
}
