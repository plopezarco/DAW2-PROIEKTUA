import 'dart:math';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'avatar_image.dart';

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.liburua}) : super(key: key);
  final Liburua liburua;

  @override
  Widget build(BuildContext context) {
    double _width = 80, _height = 110;
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(top: 15),
        child: Row(
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
                padding: const EdgeInsets.all(0),
                child: AvatarImage(
                  liburua.irudia,
                  isSVG: false,
                  radius: 8,
                ),
              )
            ]),
            const SizedBox(
              width: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  liburua.izenburua,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: liburua.generoa,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ]))
              ],
            ),
            const SizedBox(
              width: 18,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.info)),
            const SizedBox(
              width: 18,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ));
  }
}
