import 'package:characterbio/data/char_repo_impl.dart';
import 'package:characterbio/models/relatedtopics.dart';

class CharacterFetcher {
  final CharacterRepositoryImpl repo;

  CharacterFetcher(this.repo);

  Future<List<RelatedTopics>> processData() async {
    var data = await repo.fetchData();
    var parsed = (data['RelatedTopics']).cast<Map<String,dynamic>>();
    return parsed.map<RelatedTopics>((json) => RelatedTopics.fromJson(json)).toList();
  }
}