import 'package:characterbio/data/api_data_source.dart';
import 'package:characterbio/data/characters_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final ApiDataSource apiDataSource;

  CharacterRepositoryImpl(this.apiDataSource);

  @override
  Future<dynamic> fetchData() async {
    return await apiDataSource.getData();
  }
}
