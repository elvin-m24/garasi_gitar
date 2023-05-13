import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();

  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  changePassword({email, oldPassword, newPassword, scaffoldKey}) async {
    var cred = EmailAuthProvider.credential(
      email: email,
      password: oldPassword,
    );

    try {
      await currentUser!.reauthenticateWithCredential(cred);
      await currentUser!.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password Updated Successfully',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (error) {
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    PreferredSizeWidget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Change Password',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.orange,
            ),
            onPressed: () async {
              await changePassword(
                email: currentUser?.email,
                oldPassword: oldPassController.text,
                newPassword: newPassController.text,
                scaffoldKey: _scaffoldKey,
              );
            },
          )
        ],
      );
    }

    Widget passLama() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Lama',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: oldPassController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff504F5E),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passBaru() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Baru',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            TextFormField(
              controller: newPassController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff504F5E),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: 30,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage("assets/kucing.jpg")),
              ),
            ),
            passLama(),
            passBaru(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header(),
      body: content(),
      resizeToAvoidBottomInset: false,
    );
  }
}
