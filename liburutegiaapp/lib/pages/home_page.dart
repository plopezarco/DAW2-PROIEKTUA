import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/helpers/api_service.dart';
import 'package:liburutegiaapp/helpers/colors.dart';
import 'package:liburutegiaapp/widgets/avatar_image.dart';
import 'package:liburutegiaapp/widgets/book_card.dart';
import 'package:liburutegiaapp/widgets/book_cover.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/helpers/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService api = ApiService();
  Future<List<Liburua>>? ftrLiburu;
  List<Liburua> popularBooks = <Liburua>[];
  List<Liburua> newBooks = <Liburua>[];

  @override
  void initState() {
    super.initState();
    ftrLiburu = api.getLiburuakIdazlearekin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: themeMain,
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
            const AvatarImage(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png",
                isSVG: false,
                width: 27,
                height: 27)
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
              color: themeMain),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 35, right: 15),
                child: Text(
                  "Kaixo, " + globals.username,
                  style: const TextStyle(
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
                  "Ongi Etorri Liburutegira!",
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
                    "Liburu ezagunak:",
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
          color: themeMain,
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
                    child: FutureBuilder<List<Liburua>>(
                      future: ftrLiburu,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          popularBooks = snapshot.data!;
                          popularBooks.shuffle();
                          popularBooks = popularBooks.take(5).toList();
                          return getPopularBooks();
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}',
                              style: const TextStyle(color: Colors.black));
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
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
                    "Liburu berrienak: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: FutureBuilder<List<Liburua>>(
                  future: ftrLiburu,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      newBooks = snapshot.data!;
                      newBooks.sort(((a, b) => a.urtea.compareTo(b.urtea)));
                      newBooks = newBooks.take(6).toList();
                      return getLatestBooks();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}',
                          style: const TextStyle(color: Colors.black));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
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
            newBooks.length, (index) => BookCover(book: newBooks[index])),
      ),
    );
  }
}
