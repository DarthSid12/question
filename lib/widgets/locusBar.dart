// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names,
import 'dart:async';
import 'package:frontend/widgets/module.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class Locus extends StatefulWidget {
  Locus({Key? key, required this.isSpace}) : super(key: key);

  final bool isSpace;

  @override
  _LocusState createState() => _LocusState();
}

class _LocusState extends State<Locus> {
  late String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: widget.isSpace
          ? Colors.grey[900]!.withOpacity(0.0)
          : Colors.grey[500]!.withOpacity(0.1),
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 25, right: 15),
                  child: widget.isSpace
                      ? Text("")
                      : Text("What would you like to do?",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[800],
                              fontSize: 18))),
              Center(
                child: widget.isSpace
                    ? Text("")
                    : Icon(
                        Icons.mic,
                        color: Colors.grey[800],
                        size: 16,
                      ),
              )
            ],
          ),
          Center(
              child: GestureDetector(
            onTap: () {
              settings(context);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 35),
              child: Row(children: [
                Text(_timeString,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                        fontSize: 13)),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                  size: 15,
                )
              ]),
            ),
          ))
        ],
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('h:mm').format(dateTime);
  }
}
