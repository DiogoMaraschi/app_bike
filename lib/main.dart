import 'dart:io';

import 'package:desafio_academy/database/database_helper.dart';
import 'package:desafio_academy/global.dart';
import 'package:desafio_academy/pages/trip_list/trip_list_page.dart';
import 'package:desafio_academy/repository/trip_repository.dart';
import 'package:desafio_academy/service/camera.dart';
import 'package:desafio_academy/service/geolocation.dart';
import 'package:flutter/material.dart';

void main() {
  initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TripListPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Camera camera = Camera();
  File? file;

  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            file == null
                       ? const Text('Sem fotos')
                       : Image.file(file!),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          final resul = await camera.captureImage();
          setState(() {
            file = resul;
          });
          print('Image file ${file!.path}');
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
