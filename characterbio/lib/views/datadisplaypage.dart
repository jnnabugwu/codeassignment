import 'dart:convert';

import 'package:characterbio/models/relatedtopics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///
//call the api, get the response, decode the response
Future<dynamic> fecthdata() async {
  final response = await http.get(Uri.parse(
      'http://api.duckduckgo.com/?q=simpsons+characters&format=json'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final relatedTopicsList = data['RelatedTopics'];
    return relatedTopicsList;
  }
}

//creates an isolate to take characters
Future<List<RelatedTopics>> fetchCharacters(http.Client client) async {
  final response = await fecthdata();

  return parseCharacters(response);
}

List<RelatedTopics> parseCharacters(dynamic responseBody) {
  final parsed = (responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<RelatedTopics>((json) => RelatedTopics.fromJson(json))
      .toList();
}

class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchCharacters(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occured!'),
            );
          } else if (snapshot.hasData) {
            return Center(child: CharacterList(relatedtopics: snapshot.data!));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.relatedtopics});

  final List<RelatedTopics> relatedtopics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: relatedtopics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(relatedtopics[index].toString()),
          );
        });
  }
}
