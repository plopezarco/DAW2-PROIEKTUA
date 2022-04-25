import 'dart:math';

import 'package:liburutegiaapp/theme/colors.dart';
import 'package:flutter/material.dart';

import 'avatar_image.dart';

class BookCover extends StatelessWidget {
  const BookCover({Key? key, required this.book}) : super(key: key);
  final dynamic book;

  @override
  Widget build(BuildContext context) {
    double _width = 75, _height = 100;
    return Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Stack(children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 50, right: 40),
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: themeMain,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    width: _width / 2,
                    height: _height / 2,
                    decoration: BoxDecoration(
                        color:
                            Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15))),
                  )),
              Container(
                width: _width,
                height: _height,
                padding: const EdgeInsets.all(8),
                child: AvatarImage(
                  book["image"],
                  isSVG: false,
                  radius: 8,
                ),
              )
            ]),
            const SizedBox(
              height: 8,
            ),
            Text(
              book["price"],
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ));
  }
}
