import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUserController extends StateNotifier<List> {
  SearchUserController() : super([]);

  List<dynamic> onSearchCharacter(String query, List<dynamic> data) {
    if (query.isNotEmpty) {
      final result = data
          .where((element) => element
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase()))
          .toList();
      return result;
    }
    return data;
  }
}
