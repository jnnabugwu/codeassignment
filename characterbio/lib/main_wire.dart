import 'package:characterbio/flavor_config.dart';
import 'package:characterbio/main_common.dart';
import 'package:flutter/material.dart';

String wireApiLink =
    "http://api.duckduckgo.com/?q=the+wire+characters&format=json";

void main() {
  final wireConfig = FlavorConfig()
    ..appTitle = 'Wire Character Viewer'
    ..apiEndpoint = wireApiLink
    ..theme = ThemeData.light().copyWith(
        primaryColor: const Color(0xFF123456),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              backgroundColor: Color.fromARGB(255, 33, 35, 101),
            ));

  mainCommon(wireConfig);
}
