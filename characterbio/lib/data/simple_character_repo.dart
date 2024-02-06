import 'dart:convert';

import 'package:characterbio/models/relatedtopics.dart';
import 'package:http/http.dart' as http;

class SimpleCharacterRepository {
  final String api;
  final http.Client client;

  SimpleCharacterRepository({required this.api, required this.client});
  //what methods does this have
  //get characters list of characters
  //TODO: send request, parse request, or send error

  // send request
  Future<List<RelatedTopics>> getData() async {
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final preParsedData = data['RelatedTopics'];
      return parseData(preParsedData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<RelatedTopics> parseData(dynamic jsonData) {
    var parsed = (jsonData).cast<Map<String, dynamic>>();

    return parsed
        .map<RelatedTopics>((json) => RelatedTopics.fromJson(json))
        .toList();
  }
}
