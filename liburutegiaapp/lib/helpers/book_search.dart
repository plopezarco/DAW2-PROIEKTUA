import 'package:flutter/material.dart';
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/widgets/book_item.dart';

class BookSearch extends SearchDelegate {
  final List<Liburua> liburuak;
  final Function() notifyParent;
  List<Liburua> filter = [];

  BookSearch(this.liburuak, this.notifyParent);

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

    filter = liburuak
        .where((l) =>
            l.izenburua.toUpperCase().contains(query.toUpperCase().trim()))
        .toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 15, right: 15),
      shrinkWrap: false,
      itemCount: filter.length,
      itemBuilder: (BuildContext context, int index) {
        return BookItem(
          liburua: filter[index],
          notifyParent: notifyParent,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    filter = liburuak
        .where((l) =>
            l.izenburua.toUpperCase().contains(query.toUpperCase().trim()))
        .toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 15, right: 15),
      shrinkWrap: false,
      itemCount: filter.length,
      itemBuilder: (BuildContext context, int index) {
        return BookItem(
          liburua: filter[index],
          notifyParent: notifyParent,
        );
      },
    );
  }
}
