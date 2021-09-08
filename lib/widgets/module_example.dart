/// Flutter code sample for CupertinoPageScaffold

// This example shows a [CupertinoPageScaffold] with a [ListView] as a [child].
// The [CupertinoButton] is connected to a callback that increments a counter.
// The [backgroundColor] can be changed.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 60,
            color: const Color(0xffececec),
            child: Center(
                child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    Icon(
                      Icons.developer_board,
                      color: Colors.grey[800],
                      size: 23,
                    ),
                    Container(width:10,),
                    Text("module.plugin",
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                              fontSize: 14))
                  ]),
                  Icon(
                    Icons.mic,
                    color: Colors.grey[500],
                    size: 25,
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
