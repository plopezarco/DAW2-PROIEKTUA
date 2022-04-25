import 'package:flutter/material.dart';

class NetImage extends StatelessWidget {
  const NetImage({Key? key, required this.imgurl}) : super(key: key);
  final String imgurl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imgurl,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
