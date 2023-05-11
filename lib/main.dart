import 'package:flutter/material.dart';
import 'package:garasi_gitar/edit_profile.dart';
import 'package:garasi_gitar/page/account_page.dart';
import 'package:garasi_gitar/page/cart_page.dart';
import 'package:garasi_gitar/page/favorite_page.dart';
import 'package:garasi_gitar/page/home_page.dart';
import 'package:garasi_gitar/page/sign_in_page.dart';
import 'package:garasi_gitar/page/sign_up_page.dart';
import 'package:garasi_gitar/provider/page_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garasi_gitar/provider/whislist_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        routes: {
          '/sign-up': (context) => SignUpPage(),
          '/home_page': (context) => HomePage(),
          '/cart_page': (context) => CartPage(),
          '/account_page': (context) => AccountPage(),
          '/fav_page': (context) => FavoritePage(),
          '/edit-profile': (context) => EditProfilePage(),
        },
      ),
    );
  }
}
