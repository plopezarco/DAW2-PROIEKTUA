import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/pages/book_details.dart';
import 'avatar_image.dart';
import 'package:liburutegiaapp/helpers/globals.dart' as globals;

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.liburua, required this.notifyParent})
      : super(key: key);
  final Liburua liburua;
  final Function() notifyParent;

  @override
  Widget build(BuildContext context) {
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
                  child: GestureDetector(
                    child: AvatarImage(
                      liburua.irudia,
                      isSVG: false,
                      radius: 8,
                    ),
                    onTap: () {
                      showImageViewer(
                          context, Image.network(liburua.irudia).image,
                          closeButtonTooltip: "Itxi",
                          immersive: false,
                          useSafeArea: true);
                    },
                  ))
            ]),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 120,
                    child: Text(
                      liburua.izenburua,
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
                          text: liburua.generoa,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500)),
                    ])))
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetails(liburua: liburua)));
                },
                icon: const Icon(Icons.info)),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  if (!globals.cart.contains(liburua) &&
                      globals.cart.length < 4) {
                    globals.cart.add(liburua);
                  } else if (globals.cart.length >= 4) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Ezin dira 4 liburu baino gehiago aukeratu aldi berean.")));
                  } else {
                    globals.cart.remove(liburua);
                  }
                  notifyParent();
                },
                icon: !globals.cart.contains(liburua)
                    ? const Icon(Icons.add)
                    : const Icon(Icons.close))
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ));
  }
}
