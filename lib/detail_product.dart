import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garasi_gitar/models/cart_model.dart';
import 'package:garasi_gitar/models/product_model.dart';
import 'package:garasi_gitar/provider/cart_provider.dart';
import 'package:garasi_gitar/provider/whislist_provider.dart';
import 'package:provider/provider.dart';

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
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

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
                      final snackBar = SnackBar(
                        content: Text(
                          wishlistProvider.isWishlist(ProductModel(
                            id: id,
                            name: name,
                            harga: harga,
                            ketagori: ketagori,
                            deskripsi: deskripsi,
                            image: image,
                          ))
                              ? 'Product added to wishlist'
                              : 'Product removed from wishlist',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                        onPressed: () async {
                          cartProvider.addCart(
                            ProductModel(
                              id: id,
                              name: name,
                              harga: harga,
                              ketagori: ketagori,
                              deskripsi: deskripsi,
                              image: image,
                            ),
                          );
                          final snackBar = SnackBar(
                            content: Text(
                              'Product added to cart',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                            backgroundColor: Colors.white,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
