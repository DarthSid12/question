import 'package:flutter/material.dart';
import 'package:frontend/widgets/module_example.dart';
import 'package:frontend/widgets/settings.dart';
import 'package:google_fonts/google_fonts.dart';

void showModule(context) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0),
    transitionDuration: Duration(milliseconds: 120),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 640,
          width: 480,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15), child: MyApp()),
          margin: EdgeInsets.only(bottom: 75, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return FadeTransition(
        opacity: anim,
        child: child,
      );
    },
  );
}

void settings(context) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.0),
    transitionDuration: Duration(milliseconds: 75),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 465,
          width: 395,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15), child: SettingsMenu()),
          margin: EdgeInsets.only(bottom: 75, top: 87, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return FadeTransition(
        opacity: anim,
        child: child,
      );
    },
  );
}
