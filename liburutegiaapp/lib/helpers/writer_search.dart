import 'package:flutter/material.dart';
import 'package:liburutegiaapp/models/idazlea.dart';
import 'package:liburutegiaapp/widgets/writer_item.dart';

class WriterSearch extends SearchDelegate {
  final List<Idazlea> idazleak;

  List<Idazlea> filter = [];

  WriterSearch(this.idazleak);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    filter.clear();

    filter = idazleak
        .where(
            (i) => i.izena.toUpperCase().contains(query.toUpperCase().trim()))
        .toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 15, right: 15),
      shrinkWrap: false,
      itemCount: filter.length,
      itemBuilder: (BuildContext context, int index) {
        return WriterItem(idazlea: filter[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    filter = idazleak
        .where(
            (i) => i.izena.toUpperCase().contains(query.toUpperCase().trim()))
        .toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 15, right: 15),
      shrinkWrap: false,
      itemCount: filter.length,
      itemBuilder: (BuildContext context, int index) {
        return WriterItem(idazlea: filter[index]);
      },
    );
  }
}
