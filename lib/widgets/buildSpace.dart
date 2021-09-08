// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:frontend/widgets/locusBar.dart';
import 'package:frontend/widgets/module_example.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class Space {
  final String title;
  final List<Widget> flows;

  Space(this.title, this.flows);
}

class FinalSpace extends StatefulWidget {
  const FinalSpace({Key? key}) : super(key: key);

  static const routeName = '/extractArguments';

  @override
  State<FinalSpace> createState() => _FinalSpaceState();
}

class _FinalSpaceState extends State<FinalSpace> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Space;
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
                Navigator.pop(context);
              },
              backgroundColor: Colors.white.withOpacity(0.5),
              child: Icon(Icons.add),
              elevation: 1,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Locus(
                  isSpace: true,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Transform.translate(
                      offset: Offset(0, -40),
                      child: Text(args.title,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]!.withOpacity(0.9),
                              fontSize: 75))),
                )
              ],
            )));
    /*
    final args = ModalRoute.of(context)!.settings.arguments as Space;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.flows.toString()),
      ),
    );*/
  }
}
