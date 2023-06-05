import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garasi_gitar/product_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection("product");
    CollectionReference users = firestore.collection("users");
    User? user = FirebaseAuth.instance.currentUser;

    Future<String> getUsername() async {
      String? uid = user?.uid;
      if (uid != null) {
        DocumentSnapshot snapshot = await users.doc(uid).get();
        Map<String, dynamic>? userData =
            snapshot.data() as Map<String, dynamic>?;
        if (userData != null) {
          return userData['username'];
        }
      }
      return '';
    }

    Widget header() {
      return FutureBuilder<String>(
        future: getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            String username = snapshot.data!;
            return Container(
              margin: EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          username,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart_page');
                      },
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('Error retrieving username');
          }
        },
      );
    }

    Widget Slogan() {
      return Container(
        margin: EdgeInsetsDirectional.only(
          top: 10.0,
          start: 30.0,
          end: 30.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Meet Your Other Half',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget ProdukTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: 12,
          left: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Produk",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget Produk() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: product.snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data!.docs
                          .map(
                            (e) => ProductTile(
                              id: e.id,
                              name: e.get("name"),
                              harga: e.get("harga"),
                              ketagori: e.get("ketagori"),
                              deskripsi: e.get("deskripsi"),
                              image: e.get("image"),
                            ),
                          )
                          .toList())
                  : Container();
            }),
      );
    }

    return ListView(
      children: [
        header(),
        Slogan(),
        ProdukTitle(),
        Produk(),
      ],
    );
  }
}
