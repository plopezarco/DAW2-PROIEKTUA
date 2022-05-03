import 'package:liburutegiaapp/helpers/api_service.dart';
import 'package:liburutegiaapp/models/eskaera_lerroa.dart';
import 'package:flutter/material.dart';
import 'avatar_image.dart';
import 'package:intl/intl.dart';

class ItzultzekoItem extends StatelessWidget {
  ItzultzekoItem({Key? key, required this.lerroa, required this.notifyParent})
      : super(key: key);
  final EskaeraLerroa lerroa;
  final Function() notifyParent;

  ApiService api = ApiService();

  bool itzultzen = false;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    double _width = 80, _height = 130;
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Stack(children: [
              Container(
                width: _width,
                height: _height,
                padding: const EdgeInsets.all(0),
                child: AvatarImage(
                  lerroa.liburua!.irudia,
                  isSVG: false,
                  radius: 8,
                ),
              )
            ]),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 130,
                    child: Text(
                      lerroa.liburua!.izenburua,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: dateFormat.format(lerroa.itzultzeko!),
                          style: TextStyle(
                              fontSize: 14,
                              color: lerroa.itzultzeko!
                                          .compareTo(DateTime.now()) >=
                                      0
                                  ? Colors.grey[700]
                                  : Colors.red[600],
                              fontWeight: FontWeight.w500)),
                    ])))
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            lerroa.itzulita
                ? TextButton.icon(
                    icon: Icon(
                      Icons.check,
                      color: Colors.green[300],
                    ),
                    label: const Text("Itzulita"),
                    onPressed: null)
                : TextButton.icon(
                    icon: const Icon(Icons.keyboard_backspace),
                    label: const Text("Itzuli"),
                    onPressed: () {
                      itzuli();
                    })
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ));
  }

  itzuli() async {
    await api.itzuli(lerroa);
    notifyParent();
  }
}
