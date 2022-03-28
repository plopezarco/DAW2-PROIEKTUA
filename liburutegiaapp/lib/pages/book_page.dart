import 'package:badges/badges.dart';
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/services/api_service.dart';
import 'package:liburutegiaapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/widgets/writer_item.dart';

import '../widgets/book_item.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  ApiService api = ApiService();
  List<Liburua> liburuak = <Liburua>[];
  List<Idazlea> idazleak = <Idazlea>[];

  @override
  void initState() {
    super.initState();
    getLiburuak();
    getIdazleak();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: appBgColor,
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
                        color: primary,
                      ))),
              const Icon(
                Icons.search_rounded,
                color: primary,
              ),
              const SizedBox(
                width: 15,
              ),
              Badge(
                position: BadgePosition.topEnd(top: -10, end: -10),
                badgeContent: const Text(
                  '1',
                  style: TextStyle(color: Colors.white),
                ),
                child: const Icon(
                  Icons.shopping_bag_rounded,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TabBar(
                indicatorColor: primary,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primary,
                ),
                labelPadding: const EdgeInsets.only(top: 8, bottom: 8),
                unselectedLabelColor: primary,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Text(
                    "Liburuak",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Idazleak",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      children: getLiburuakList()),
                  ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      children: getIdazleakList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLiburuakList() {
    return List.generate(
        liburuak.length, (index) => BookItem(liburua: liburuak[index]));
  }

  getIdazleakList() {
    return List.generate(
        idazleak.length, (index) => WriterItem(idazlea: idazleak[index]));
  }

  Future getLiburuak() async {
    List<Liburua> book = await api.getBooks();
    setState(() {
      liburuak = book;
    });
  }

  Future getIdazleak() async {
    List<Idazlea> writers = await api.getIdazleak();
    setState(() {
      idazleak = writers;
    });
  }
}
