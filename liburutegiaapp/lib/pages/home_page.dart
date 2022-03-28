import 'dart:ui';
import 'package:liburutegiaapp/data/json.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/services/api_service.dart';
import 'package:liburutegiaapp/theme/colors.dart';
import 'package:liburutegiaapp/widgets/avatar_image.dart';
import 'package:liburutegiaapp/widgets/book_card.dart';
import 'package:liburutegiaapp/widgets/book_cover.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService api = ApiService();
  late Future<List<Liburua>> futureLiburuak;

  @override
  void initState() {
    super.initState();
    futureLiburuak = api.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: primary,
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.vertical_distribute_rounded,
                    ))),
            const Icon(Icons.search_rounded),
            const SizedBox(
              width: 15,
            ),
            AvatarImage(profile, isSVG: false, width: 27, height: 27)
          ],
        ),
      ),
      body: getStackBody(),
    );
  }

  getTopBlock() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              color: primary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 35, right: 15),
                child: const Text(
                  "Hi, Sangvaleap",
                  style: TextStyle(
                      color: secondary,
                      fontSize: 23,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 35, right: 15),
                child: const Text(
                  "Welcome to Lifemasto!",
                  style: TextStyle(
                      color: secondary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: const Text(
                    "Popular Books",
                    style: TextStyle(
                        color: secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          color: primary,
          child: Container(
            decoration: const BoxDecoration(
                color: appBgColor,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(100))),
          ),
        )
      ],
    );
  }

  getStackBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                child: getTopBlock(),
              ),
              Positioned(
                  top: 140,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 260,
                    child: getPopularBooks(),
                  )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: const Text(
                    "Latest Books",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: getLatestBooks(),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }

  getPopularBooks() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(popularBooks.length,
            (index) => BookCard(book: popularBooks[index])),
      ),
    );
  }

  getLatestBooks() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 5),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            latestBooks.length, (index) => BookCover(book: latestBooks[index])),
      ),
    );
  }
}
