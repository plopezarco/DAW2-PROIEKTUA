import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/helpers/colors.dart';
import '../widgets/avatar_image.dart';
import 'package:liburutegiaapp/models/liburua.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({Key? key, required this.liburua}) : super(key: key);

  final Liburua liburua;

  @override
  Widget build(BuildContext context) {
    double _width = 300;
    double _height = 400;

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
            liburua.izenburua,
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
                        child: SizedBox(
                            width: _width,
                            height: _height,
                            child: GestureDetector(
                              child: AvatarImage(
                                liburua.irudia,
                                isSVG: false,
                                radius: 8,
                              ),
                              onTap: () {
                                showImageViewer(context,
                                    Image.network(liburua.irudia).image,
                                    closeButtonTooltip: "Itxi");
                              },
                            )),
                        flex: 6),
                    const SizedBox(width: 15),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Informazio Teknikoa",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 12,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Idazlea: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: liburua.idazlea != null
                                          ? liburua.idazlea!.izena
                                          : "Ez da idazlea aurkitu"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Generoa: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: liburua.generoa),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Urtea: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: liburua.urtea.toString()),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Orri Kopurua: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: liburua.orriKopurua.toString()),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'ISBN: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: liburua.isbn),
                                ],
                              ),
                            ),
                          ],
                        ),
                        flex: 6)
                  ],
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
                        liburua.sinopsia,
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
