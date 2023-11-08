import 'package:characterbio/models/icon.dart';

class RelatedTopics {
  String firstURL;
  String text;
  String result;
  Icon icon;

  RelatedTopics(this.firstURL, this.text, this.result, this.icon);

  factory RelatedTopics.fromJson(dynamic json) {
    return RelatedTopics(json['FirstURL'] as String, json['Text'] as String,
        json['Result'] as String, Icon.fromJson(json['Icon']));
  }
  @override
  String toString() {
    return 'RelatedTopics(firstURL: $firstURL,text: $text,result:$result, icon:$icon)';
  }

  String get getIcon {
    return icon.url;
  }
}
