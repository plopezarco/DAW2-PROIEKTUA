import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/theme/colors.dart';
import 'package:liburutegiaapp/widgets/avatar_image.dart';
import 'package:liburutegiaapp/widgets/net_img.dart';

class WriterDetails extends StatelessWidget {
  const WriterDetails({Key? key, required this.idazlea}) : super(key: key);

  final Idazlea idazlea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: themeMain,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            idazlea.izena,
            style: const TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          child: NetImage(
                            imgurl: idazlea.irudia,
                          ),
                          onTap: () {
                            showImageViewer(
                                context, Image.network(idazlea.irudia).image,
                                closeButtonTooltip: "Itxi");
                          },
                        ),
                        flex: 5),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Liburu batzuk",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(
                                  height: 12,
                                ),
                                idazlea.liburuak.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: idazlea.liburuak.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            child: Text(
                                                idazlea
                                                    .liburuak[index].izenburua,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                          );
                                        })
                                    : const Text(
                                        "Ez daukagu idazle honen libururik :(",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                              ],
                            )),
                        flex: 5)
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                flex: 1),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        idazlea.biografia,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    )),
                flex: 1)
          ],
        ),
      ),
    );
  }
}
