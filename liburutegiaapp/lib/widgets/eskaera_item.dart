import 'package:liburutegiaapp/models/eskaera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liburutegiaapp/models/eskaera_lerroa.dart';

class EskaeraItem extends StatelessWidget {
  const EskaeraItem(
      {Key? key,
      required this.eskaera,
      required this.notifyParent,
      required this.saskiaIkusi})
      : super(key: key);
  final Eskaera eskaera;
  final Function() notifyParent;
  final Function(List<EskaeraLerroa> lerroak) saskiaIkusi;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 200,
                          child: Text(
                            eskaera.izena.trim() + " " + eskaera.abizena.trim(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                          width: 100,
                          child: Text(
                            eskaera.lerroak!.length.toString() + " liburu",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 200,
                          child: Text(
                            "Helbidea: " + eskaera.helbidea,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[600],
                                fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                          width: 100,
                          child: Text(
                            "Data: " + dateFormat.format(eskaera.eskaeraData),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[600],
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ],
              ),
              flex: 5,
            ),
            Expanded(
                child: IconButton(
                    onPressed: () {
                      saskiaIkusi(eskaera.lerroak!);
                    },
                    icon: const Icon(Icons.info)),
                flex: 1)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ));
  }
}
