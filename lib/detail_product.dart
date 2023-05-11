import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garasi_gitar/bottom_nav.dart';
import 'package:garasi_gitar/models/product_model.dart';
import 'package:garasi_gitar/provider/whislist_provider.dart';
import 'package:garasi_gitar/service/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  final String name, ketagori, deskripsi, image, id;
  final num harga;

  const ProductPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.harga,
      required this.ketagori,
      required this.deskripsi,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference carts = firestore.collection("cart");
    User? user = FirebaseAuth.instance.currentUser;

    Future<void> saveCartData(
        List<Map<String, dynamic>> cartData, String userId) async {
      final batch = FirebaseFirestore.instance.batch();
      for (final item in cartData) {
        final cartItemRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc();
        batch.set(cartItemRef, item);
      }
      await batch.commit();
    }

    Widget header() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                  ),
                ),
                Icon(
                  Icons.shopping_bag,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.network(
            image,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.cover,
          )
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: Colors.black,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          ketagori,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      wishlistProvider.setProduct(
                        ProductModel(
                          id: id,
                          name: name,
                          harga: harga,
                          ketagori: ketagori,
                          deskripsi: deskripsi,
                          image: image,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.favorite,
                      color: wishlistProvider.isWishlist(ProductModel(
                        id: id,
                        name: name,
                        harga: harga,
                        ketagori: ketagori,
                        deskripsi: deskripsi,
                        image: image,
                      ))
                          ? Colors.orange
                          : Colors.grey,
                      size: 46,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: 30,
                right: 30,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price starts from',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Rp ${harga}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    deskripsi,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(30),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      child: TextButton(
                        onPressed: () {
                          createKeranjang(
                            name: name,
                            harga: harga,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Berhasil Ditambah",
                            ),
                          ));
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.orange,
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            header(),
            content(),
          ],
        ));
  }
}
