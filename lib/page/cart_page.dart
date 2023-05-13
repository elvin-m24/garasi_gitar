import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garasi_gitar/bottom_nav.dart';
import 'package:garasi_gitar/cart_tile.dart';
import 'package:garasi_gitar/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Guitars Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      );
    }

    Widget emptyCart() {
      return Center(
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
                'Your cart empty',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Find your guitar now!',
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
                    Navigator.pop(context, '/home_page');
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
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        children: cartProvider.carts
            .map((e) => CartCard(
                  cart: e,
                  id: e.id,
                  product: e.product,
                  quantity: e.quantity,
                ))
            .toList(),
      );
    }

    Widget customBottomNav() {
      return Container(
        height: 180,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                  ),
                  Text(
                    'Rp ${cartProvider.totalPrice()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 0.3,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TextButton(
                onPressed: () async {
                  cartProvider.carts.asMap().forEach((index, cart) async {
                    await FirebaseFirestore.instance.collection('carts').add({
                      'id': cart.id,
                      'product': cart.product.name,
                      'quantity': cart.quantity,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                    cartProvider.clearCart();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Checkout Sekarang',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: cartProvider.carts.length == 0 ? emptyCart() : content(),
      bottomNavigationBar:
          cartProvider.carts.length == 0 ? SizedBox() : customBottomNav(),
    );
  }
}
