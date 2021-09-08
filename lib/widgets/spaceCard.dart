// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontend/widgets/buildSpace.dart';
import 'package:frontend/widgets/module_example.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

Widget spaceCard(String title, String update, List<Widget> connectedModules,
    List<String> flows, context) {
  return Padding(
      padding: EdgeInsets.all(25),
      child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  FinalSpace.routeName,
                  arguments: Space(title, connectedModules),
                );
              },
              child: Container(
                height: 225,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                color: Colors.grey[700],
                              ),
                            ),
                            Container(
                              height: 8,
                            ),
                            Text(
                              update,
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                              ),
                            ),
                            Expanded(child: Container()),
                            Row(
                              children: connectedModules,
                            ),
                            Container(
                              color: Colors.grey[500],
                              height: 1,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: 150,
                            ),
                            Text(
                              flows.toString(),
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 175,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 15,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),
                                Transform.translate(
                                    offset: Offset(-30, 5),
                                    child: Transform.rotate(
                                      angle: -math.pi / 30,
                                      child: Container(
                                        height: 175,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 0,
                                                blurRadius: 15,
                                                offset: Offset(4, 4),
                                              ),
                                            ],
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2))),
                                      ),
                                    ))
                              ],
                            ))
                      ],
                    )),
              ))));
}
