import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsMenu extends StatefulWidget {
  SettingsMenu({Key? key}) : super(key: key);

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  double _brightness = 70;
  double _volume = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 6,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.brightness_medium,
                        color: Colors.grey[700],
                      )),
                  Expanded(
                      child: SliderTheme(
                          data: SliderThemeData(
                              trackHeight: 16,
                              thumbColor: Colors.white,
                              thumbShape:
                                  RoundSliderThumbShape(enabledThumbRadius: 9)),
                          child: Slider(
                            value: _brightness,
                            min: 0,
                            max: 100,
                            label: _volume.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _brightness = value;
                              });
                            },
                          ))),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Icon(
                        Icons.volume_up,
                        color: Colors.grey[700],
                      )),
                  Expanded(
                      child: SliderTheme(
                          data: SliderThemeData(
                              trackHeight: 16,
                              thumbColor: Colors.white,
                              thumbShape:
                                  RoundSliderThumbShape(enabledThumbRadius: 9)),
                          child: Slider(
                            value: _volume,
                            min: 0,
                            max: 100,
                            label: _volume.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _volume = value;
                              });
                            },
                          ))),
                ],
              ),
              settingsHeading("General"),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      settingsCircle(Icons.signal_wifi_4_bar, true),
                      settingsCircle(Icons.bluetooth, true),
                      settingsCircle(Icons.airplanemode_inactive, false),
                      settingsTile("63%", Icons.battery_charging_full)
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      settingsCircle(Icons.leak_remove, false),
                      settingsCircle(Icons.cloud_upload, true),
                      settingsCircle(Icons.dark_mode, false),
                      settingsTile("Secured", Icons.security)
                    ],
                  )),
              settingsHeading("Developer"),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 5),
                  child: Row(
                    children: [
                      settingsTile("Terminal", Icons.developer_mode),
                      settingsTile("Usage", Icons.data_usage),
                      settingsCircle(Icons.developer_board, false),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 5),
                  child: Row(
                    children: [
                      settingsTile("v1.0", Icons.perm_device_info),
                      settingsTile("10.0.1.1", Icons.wifi_tethering),
                      settingsCircle(Icons.devices, true),
                    ],
                  )),
            ],
          )),
    );
  }
}

Widget settingsHeading(String text) {
  return Padding(
      padding: EdgeInsets.only(top: 6, bottom: 6, left: 16),
      child: Text(text,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              color: Colors.grey[800],
              fontSize: 14)));
}

Widget settingsCircle(IconData icon, bool status) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: 50,
          color: status ? Colors.blue : Colors.grey[300],
          child: Center(
            child: Icon(
              icon,
              color: status ? Colors.white : Colors.grey[500],
            ),
          ),
        )),
  );
}

Widget settingsTile(String label, IconData icon) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          width: 125,
          color: Colors.white.withOpacity(0.5),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Icon(
                          icon,
                          color: Colors.grey[700],
                        ),
                      ),
                      Center(
                        child: Text(label,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                                fontSize: 15)),
                      )
                    ],
                  ))),
        )),
  );
}
