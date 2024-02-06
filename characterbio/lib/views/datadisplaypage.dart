import 'package:characterbio/data/simple_character_repo.dart';
import 'package:characterbio/models/relatedtopics.dart';
import 'package:characterbio/views/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final TextEditingController _searchController = TextEditingController();
String query = '';

///have the text editting controller update
///the search pass the search through to the
class Display extends StatefulWidget {
  const Display({super.key, required this.api});

  final String api;

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  // repo = CharacterRepository(api: widget.api, client: http.Client());
  // jsonData = await repo.getData();
  // _list = repo.parseData(jsonData);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        title: TextField(
          onChanged: (value) {
            setState(() => query = value);
          },
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none),
        ),
      ),
      body: FutureBuilder(
          future:
              SimpleCharacterRepository(api: widget.api, client: http.Client())
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
                  child: CharacterList(
                    relatedTopics: snapshot.data!,
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.relatedTopics});

  final List<RelatedTopics> relatedTopics;

  @override
  Widget build(BuildContext context) {
    List<String> relatedTopicsNames = [];
    List<String> relatedTopicsDescriptions = [];
    List<String> relatedTopicsSearchables = [];

    for (var i = 0; i < relatedTopics.length; i++) {
      //Split then take the first element
      relatedTopicsSearchables.add(relatedTopics[i].text);
      relatedTopicsNames.add(relatedTopics[i].text.split("-").first);
      relatedTopicsDescriptions.add(relatedTopics[i].text.split("-").last);
    }

    final result = relatedTopics
        .where(
            (element) => element.text.toString().toLowerCase().contains(query))
        .toList();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          // List<String> info = relatedtopics[index].text.split('-');
          // final description = info[1];

          return Material(
            child: ListTile(
              title: Text('${result[index].text} + $index'),
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
