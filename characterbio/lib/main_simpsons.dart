import 'package:characterbio/flavor_config.dart';
import 'package:characterbio/main_common.dart';
import 'package:flutter/material.dart';

String simpsonsApiLink =
    "http://api.duckduckgo.com/?q=simpsons+characters&format=json";

void main() {
  final simpsonConfig = FlavorConfig()
    ..appTitle = 'Simpsons Character Viewer'
    ..apiEndpoint = simpsonsApiLink
    ..theme = ThemeData.light().copyWith(
        primaryColor: const Color(0xFF123456),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              backgroundColor: const Color(0xFF654321),
            ));

  mainCommon(simpsonConfig);
}
