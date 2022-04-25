import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage(this.name,
      {this.width = 100,
      this.height = 100,
      this.bgColor,
      this.borderWidth = 0,
      this.borderColor,
      this.trBackground = false,
      this.isSVG = true,
      this.radius = 50});
  final String name;
  final double width;
  final double height;
  final double borderWidth;
  final Color? borderColor;
  final Color? bgColor;
  final bool trBackground;
  final bool isSVG;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return isSVG
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(
                  color: borderColor ?? Theme.of(context).cardColor,
                  width: borderWidth),
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.string(
                multiavatar(name, trBackground: trBackground)),
          )
        : SizedBox(
            width: width,
            height: height,
            child: Image.network(
              name,
              fit: BoxFit.cover,
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
            ));
  }
}
