import 'package:flutter/material.dart';

//TODO: if icon url is "" string then return Image.asset() else Image.network
//

class ImagePicker extends StatelessWidget {
  const ImagePicker({super.key, required this.iconUrl});

  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Image.asset('lib/assets/images/simpsons.png');
  }
}
