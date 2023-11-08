import 'package:characterbio/controllers/search_controller.dart';
import 'package:characterbio/data/characters_repository.dart';
import 'package:characterbio/models/relatedtopics.dart';
import 'package:characterbio/views/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final searchCharacterProvider = StateProvider<String>((ref) => '');
final textEditingContoller = TextEditingController();

///have the text editting controller update
///the search pass the search through to the
class Display extends ConsumerWidget {
  const Display({super.key, required this.api});
  final String api;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          Material(
              child: TextFormField(
            controller: textEditingContoller,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          )),
          FutureBuilder(
              future: CharacterRepository(api: api, client: http.Client())
                  .getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occured!'),
                  );
                } else if (snapshot.hasData) {
                  //if query is emtpy return snapshot
                  //else return
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * .75,
                      child: CharacterList(relatedtopics: snapshot.data!));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.relatedtopics});

  final List<RelatedTopics> relatedtopics;

  @override
  Widget build(BuildContext context) {
    List<String> relatedTopicsNames = [];
    List<String> relatedtopicsDescriptions = [];
    List<String> relatedtopicsSearchables = [];

    for (var i = 0; i < relatedtopics.length; i++) {
      //Split then take the first element
      relatedtopicsSearchables.add(relatedtopics[i].text);
      relatedTopicsNames.add(relatedtopics[i].text.split("-").first);
      relatedtopicsDescriptions.add(relatedtopics[i].text.split("-").last);
    }

    final result = relatedtopics
        .where((element) => element.text.toString().toLowerCase().contains(''))
        .toList();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          // List<String> info = relatedtopics[index].text.split('-');
          // final description = info[1];

          return Material(
            child: ListTile(
              title: Text(result[index].text.toString()),
              onTap: () {
                // //Create Screen
                Navigator.pushNamed(context, DetailPage.routeName,
                    arguments: result[index]);
              },
            ),
          );
        });
  }
}
