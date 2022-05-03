import 'package:liburutegiaapp/models/eskaera.dart';
import 'package:liburutegiaapp/helpers/api_service.dart';
import 'package:liburutegiaapp/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/models/eskaera_lerroa.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/widgets/eskaera_item.dart';
import 'package:liburutegiaapp/helpers/globals.dart' as globals;
import 'package:liburutegiaapp/widgets/itzultzeko_item.dart';
import 'package:liburutegiaapp/widgets/net_img.dart';

class EskaerakPage extends StatefulWidget {
  const EskaerakPage({Key? key}) : super(key: key);

  @override
  _EskaerakPageState createState() => _EskaerakPageState();
}

class _EskaerakPageState extends State<EskaerakPage> {
  ApiService api = ApiService();
  List<Eskaera> eskaerak = <Eskaera>[];
  List<EskaeraLerroa> itzultzeko = <EskaeraLerroa>[];

  Future<List<Eskaera>>? ftrEskaerak;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    ftrEskaerak = api.getEskaerakByErabiltzailea(globals.username);
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
            body: Padding(
              child: Column(
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
                          offset:
                              const Offset(1, 1), // changes position of shadow
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
                          "Nire Eskaerak",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Itzulketak",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        FutureBuilder<List<Eskaera>>(
                          future: ftrEskaerak,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              eskaerak = snapshot.data!;
                              eskaerak.removeWhere((p) => p.lerroak!.isEmpty);
                              return getEskaerakList();
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}',
                                  style: const TextStyle(color: Colors.black));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        FutureBuilder<List<Eskaera>>(
                          future: ftrEskaerak,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              List<Eskaera> pedidos = snapshot.data!;
                              itzultzeko.clear();
                              for (Eskaera esk in pedidos) {
                                for (EskaeraLerroa l in esk.lerroak!) {
                                  l.itzultzeko = esk.itzultzeData;
                                }
                                itzultzeko.addAll(esk.lerroak!);
                              }
                              return getItzultzekoList();
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}',
                                  style: const TextStyle(color: Colors.black));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 40),
            )));
  }

  getEskaerakList() {
    return RefreshIndicator(
        onRefresh: () async {
          ftrEskaerak = api.getEskaerakByErabiltzailea(globals.username);
          setState(() {});
        },
        child: eskaerak.isEmpty
            ? const Center(
                child: Text("Ez daukazu eskaerarik"),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 15, right: 15),
                shrinkWrap: false,
                itemCount: eskaerak.length,
                itemBuilder: (BuildContext context, int index) {
                  return EskaeraItem(
                    eskaera: eskaerak[index],
                    notifyParent: refresh,
                    saskiaIkusi: saskiaIkusi,
                  );
                },
              ));
  }

  getItzultzekoList() {
    return RefreshIndicator(
        onRefresh: () async {
          ftrEskaerak = api.getEskaerakByErabiltzailea(globals.username);
          setState(() {});
        },
        child: eskaerak.isEmpty
            ? const Center(
                child: Text("Ez daukazu itzulketarik"),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 15, right: 15),
                shrinkWrap: false,
                itemCount: itzultzeko.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItzultzekoItem(
                      lerroa: itzultzeko[index], notifyParent: refresh);
                },
              ));
  }

  saskiaIkusi(List<EskaeraLerroa> lerroak) {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    return SizedBox(
                      height: lerroak.length > 2 ? height - 250 : height - 450,
                      width: width - 100,
                      child: Builder(builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Eskaera: " +
                                        lerroak.length.toString() +
                                        " liburu",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 22.0),
                                  )),
                              Expanded(
                                  child: GridView.builder(
                                      itemBuilder: ((context, index) {
                                        Liburua l = lerroak[index].liburua!;
                                        return Center(
                                          child: Stack(children: [
                                            NetImage(imgurl: l.irudia),
                                          ]),
                                        );
                                      }),
                                      itemCount: lerroak.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 250,
                                              childAspectRatio: 0.7,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5)),
                                  flex: 6),
                            ],
                          );
                        });
                      }),
                    );
                  },
                ),
              );
            }));
  }

  refresh() {
    ftrEskaerak = api.getEskaerakByErabiltzailea(globals.username);
    setState(() {});
  }
}
