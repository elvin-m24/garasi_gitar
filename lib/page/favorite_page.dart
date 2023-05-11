import 'package:flutter/material.dart';
import 'package:garasi_gitar/provider/page_provider.dart';
import 'package:garasi_gitar/provider/whislist_provider.dart';
import 'package:garasi_gitar/wishlist_tile.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    Widget header() {
      return AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Favorite Guitars',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget Wishlist() {
      return Expanded(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/electric-guitar.png',
                width: 80,
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                'You don\'t have favorite guitar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Find your favorite guitar now!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 44,
                child: TextButton(
                  onPressed: () {
                    pageProvider.selectedIndex = 0;
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 24,
                    ),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Explore Store',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            children: wishlistProvider.wishlist
                .map(
                  (product) => WhislistCard(
                    id: product.id,
                    name: product.name,
                    harga: product.harga,
                    ketagori: product.ketagori,
                    deskripsi: product.deskripsi,
                    image: product.image,
                    product: product,
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        wishlistProvider.wishlist.length == 0 ? Wishlist() : content(),
      ],
    );
  }
}
