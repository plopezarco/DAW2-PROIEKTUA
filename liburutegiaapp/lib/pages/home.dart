import 'package:liburutegiaapp/pages/pages.dart';
import 'package:liburutegiaapp/helpers/colors.dart';
import 'package:liburutegiaapp/pages/eskaerak_page.dart';
import 'package:liburutegiaapp/widgets/bottombar_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        bottomNavigationBar: getBottomBar(),
        body: getPage());
  }

  Widget getBottomBar() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
        ),
        color: bottomBarColor,
      ),
      child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = 0;
                });
              },
              child: BottomBarItem(Icons.home, "",
                  isActive: activeTab == 0, activeColor: secondary),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = 1;
                });
              },
              child: BottomBarItem(Icons.my_library_books_rounded, "",
                  isActive: activeTab == 1, activeColor: secondary),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = 2;
                });
              },
              child: BottomBarItem(Icons.bookmarks, "",
                  isActive: activeTab == 2, activeColor: secondary),
            )
          ])),
    );
  }

  Widget getPage() {
    return Container(
      decoration: const BoxDecoration(color: bottomBarColor),
      child: Container(
        decoration: const BoxDecoration(
            color: appBgColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(80))),
        child: IndexedStack(
          index: activeTab,
          children: const <Widget>[HomePage(), BookPage(), EskaerakPage()],
        ),
      ),
    );
  }
}
