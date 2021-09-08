// ignore_for_file: file_names

import "package:flutter/material.dart";
import 'package:frontend/widgets/spaceCard.dart';
import 'package:google_fonts/google_fonts.dart';

Widget flowTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(top: 50, left: 25, right: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800]),
        ),
        Container(
          width: 5,
        ),
        Icon(
          Icons.north_west,
          size: 20,
          color: Colors.grey[600],
        )
      ],
    ),
  );
}

class Timeline extends StatefulWidget {
  Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            flowTitle("Today"),
            Center(
                child: Row(
              children: [
                spaceCard(
                    "space.title",
                    "Updated just now",
                    [
                      Icon(Icons.developer_board),
                      Icon(Icons.memory),
                      Icon(Icons.extension_outlined),
                      Icon(Icons.shop_2_outlined)
                    ],
                    ["flow.1", "flow.2", "flow.3"],
                    context),
              ],
            )),
          ],
        ));
  }
}
