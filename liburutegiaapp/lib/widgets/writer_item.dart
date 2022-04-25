import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/pages/writer_details.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/widgets/net_img.dart';
import 'avatar_image.dart';

class WriterItem extends StatelessWidget {
  const WriterItem({Key? key, required this.idazlea}) : super(key: key);
  final Idazlea idazlea;

  @override
  Widget build(BuildContext context) {
    double _width = 110, _height = 110;
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
                    child: NetImage(
                      imgurl: idazlea.irudia,
                    ),
                    onTap: () {
                      showImageViewer(
                          context, Image.network(idazlea.irudia).image,
                          closeButtonTooltip: "Itxi");
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
                    width: 130,
                    child: Text(
                      idazlea.izena,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ))
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
                          builder: (context) =>
                              WriterDetails(idazlea: idazlea)));
                },
                icon: const Icon(Icons.info)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ));
  }
}
