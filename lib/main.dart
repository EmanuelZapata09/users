import 'package:flutter/material.dart';
import 'package:users/acceso.dart';
import 'package:users/menu.dart';

//import 'package:users/acceso.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: Acceso()
        home: Acceso());
  }
}
