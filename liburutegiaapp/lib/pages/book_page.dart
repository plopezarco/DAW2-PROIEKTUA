import 'package:badges/badges.dart';
import 'package:liburutegiaapp/helpers/book_search.dart';
import 'package:liburutegiaapp/helpers/writer_search.dart';
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/services/api_service.dart';
import 'package:liburutegiaapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/widgets/writer_item.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:liburutegiaapp/widgets/book_item.dart';
import 'package:liburutegiaapp/helpers/globals.dart' as globals;

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  ApiService api = ApiService();
  List<Liburua> liburuak = <Liburua>[];
  List<Idazlea> idazleak = <Idazlea>[];

  Future<List<Liburua>>? ftrLiburu;
  Future<List<Idazlea>>? ftrIdazle;

  List<Liburua> liburuFilter = <Liburua>[];
  List<String> generoFilter = <String>[];

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    ftrLiburu = api.getLiburuakIdazlearekin();
    ftrIdazle = api.getIdazleakLiburuekin();
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
                      child: IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                          color: primary,
                        ),
                        onPressed: () {
                          openFilter(context);
                        },
                      ))),
              IconButton(
                icon: const Icon(Icons.search_rounded, color: primary),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: tabIndex == 0
                          ? BookSearch(liburuak, refresh)
                          : WriterSearch(idazleak));
                },
              ),
              const SizedBox(
                width: 15,
              ),
              Badge(
                position: BadgePosition.topEnd(top: -10, end: -10),
                badgeContent: Text(
                  globals.cart.length.toString(),
                  style: const TextStyle(color: Colors.white),
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
                onTap: (index) {
                  tabIndex = index;
                },
                indicatorColor: themeMain,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeMain,
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
                  FutureBuilder<List<Liburua>>(
                    future: ftrLiburu,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        liburuak = snapshot.data!;
                        if (liburuFilter.isEmpty) {
                          liburuFilter.addAll(liburuak);
                        }
                        return getLiburuakList();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}',
                            style: const TextStyle(color: Colors.black));
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  FutureBuilder<List<Idazlea>>(
                    future: ftrIdazle,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        idazleak = snapshot.data!;
                        return getIdazleakList();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}',
                            style: const TextStyle(color: Colors.black));
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLiburuakList() {
    return RefreshIndicator(
        onRefresh: () async {
          ftrLiburu = api.getLiburuakIdazlearekin();
          setState(() {});
        },
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 15, right: 15),
          shrinkWrap: false,
          itemCount: liburuFilter.length,
          itemBuilder: (BuildContext context, int index) {
            return BookItem(
              liburua: liburuFilter[index],
              notifyParent: refresh,
            );
          },
        ));
  }

  getIdazleakList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 15, right: 15),
      shrinkWrap: false,
      itemCount: idazleak.length,
      itemBuilder: (BuildContext context, int index) {
        return WriterItem(idazlea: idazleak[index]);
      },
    );
  }

  getGeneroak() {
    List<String> generoak = [];
    for (Liburua l in liburuak) {
      !generoak.contains(l.generoa) ? generoak.add(l.generoa) : null;
    }
    return generoak;
  }

  openFilter(BuildContext context) async {
    if (generoFilter.isEmpty) {
      generoFilter = getGeneroak();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          minChildSize: 0.1,
          initialChildSize: 0.1 + generoFilter.length * 0.1,
          maxChildSize: 0.1 + generoFilter.length * 0.1,
          cancelText: Text(
            "ATZERA",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          title: const Text("Aukeratu"),
          items: generoFilter.map((g) => MultiSelectItem(g, g)).toList(),
          initialValue: getGeneroak(),
          onConfirm: (values) {
            liburuFilter =
                liburuak.where((e) => values.contains(e.generoa)).toList();
            setState(() {});
          },
        );
      },
    );
  }

  refresh() {
    setState(() {});
  }
}
