import 'dart:math';
import 'package:liburutegiaapp/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'avatar_image.dart';

class BookCover extends StatelessWidget {
  const BookCover({Key? key, required this.book}) : super(key: key);
  final Liburua book;

  @override
  Widget build(BuildContext context) {
    double _width = 75, _height = 100;
    return Container(
        margin: const EdgeInsets.only(right: 15),
        child: SizedBox(
            width: 80,
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                      padding: const EdgeInsets.only(bottom: 50, right: 40),
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        width: _width / 2,
                        height: _height / 2,
                        decoration: BoxDecoration(
                            color: Color(Random().nextInt(0xffffffff))
                                .withAlpha(0xff),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15))),
                      )),
                  Container(
                    width: _width,
                    height: _height,
                    padding: const EdgeInsets.all(8),
                    child: AvatarImage(
                      book.irudia,
                      isSVG: false,
                      radius: 8,
                    ),
                  ),
                ]),
                Text(
                  book.izenburua,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            )));
  }
}
