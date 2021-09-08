// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/widgets/buildSpace.dart';
import 'package:frontend/widgets/mainSpace.dart';
import 'package:frontend/widgets/module.dart';
import 'package:frontend/widgets/searchModule.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:frontend/widgets/locusBar.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        FinalSpace.routeName: (context) => const FinalSpace(),
      },
      title: 'mercury',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Kiri(title: 'mercury'),
    );
  }
}

class Kiri extends StatefulWidget {
  const Kiri({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Kiri> createState() => _KiriState();
}

class _KiriState extends State<Kiri> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mer.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModule(context);
              },
              backgroundColor: Colors.white.withOpacity(0.5),
              child: Icon(Icons.add),
              elevation: 1,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Locus(
                    isSpace: false,
                  ),
                  Timeline(),
                  Container(height: 500, width: 1000, child: SearchModule()),
                  SizedBox(height: 100)
                ],
              ),
            )));
  }
}
