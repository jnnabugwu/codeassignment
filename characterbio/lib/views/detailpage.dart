import 'package:characterbio/controllers/imagecontroller.dart';
import 'package:characterbio/models/relatedtopics.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.character});
  static const routeName = '/detailPage';

  final RelatedTopics character;
  @override
  Widget build(BuildContext context) {
    final name = character.text.split('-').first;
    final description = character.text.split('-').last;

    return Material(
      child: Column(
        children: [
          // ImagePicker(iconUrl: character.getIcon),
          Text(name),
          Text(description),
        ],
      ),
    );
  }
}
