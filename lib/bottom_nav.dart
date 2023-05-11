import 'package:flutter/material.dart';
import 'package:garasi_gitar/page/account_page.dart';
import 'package:garasi_gitar/page/favorite_page.dart';
import 'package:garasi_gitar/page/home_page.dart';
import 'package:garasi_gitar/provider/page_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget bottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: pageProvider.selectedIndex,
            onTap: (value) {
              print(value);
              pageProvider.selectedIndex = value;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Icon(
                    Icons.home,
                    color: pageProvider.selectedIndex == 0
                        ? Colors.orange
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: pageProvider.selectedIndex == 1
                        ? Colors.orange
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Icon(
                    Icons.person,
                    color: pageProvider.selectedIndex == 2
                        ? Colors.orange
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.selectedIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return FavoritePage();
          break;
        case 2:
          return AccountPage();
          break;
        default:
          return HomePage();
      }
    }

    return Scaffold(
      bottomNavigationBar: bottomNav(),
      body: body(),
    );
  }
}
