// 4. define a class with a mixin
class Icon {
  final String url;

  Icon({
    required this.url,
  });

  factory Icon.fromJson(dynamic json) {
    final url = json['URL'] as String;
    return Icon(url: url);
  }

  String get getUrl {
    return url;
  }
}
