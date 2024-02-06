import 'package:characterbio/data/api_data_source.dart';
import 'package:characterbio/flavor_config.dart';
import 'package:characterbio/models/relatedtopics.dart';
import 'package:characterbio/views/datadisplaypage.dart';
import 'package:characterbio/views/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var flavorConfigProvider = StateProvider((ref) => FlavorConfig());

void mainCommon(FlavorConfig config) {
  flavorConfigProvider = StateProvider((ref) => config);

  runApp(ProviderScope(
      child: MyApp(
    ref: config,
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.ref});
  final FlavorConfig ref;

  get name => null;
  get characterIcon => null;
  get description => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ref.appTitle,
      theme: ref.theme,
      routes: {
        '/': (context) => Display(api: ref.apiEndpoint),
        DetailPage.routeName: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as RelatedTopics;
          return DetailPage(character: args);
        }
      },
    );
  }
}
