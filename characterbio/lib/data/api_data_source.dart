import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiDataSource {
  final String url;

  ApiDataSource(this.url);
//get Data return the json data
  Future<dynamic> getData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

//final preParsedData = data['RelatedTopics'];
