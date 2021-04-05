import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../authentication/app/services/firebase_auth_service.dart';
import '../Screens/cart_screen.dart';
import '../Screens/category_screen.dart';
import '../Screens/purchase_history_screen.dart';
import '../data.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  var _overlay = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(31, 31, 38, 1),
        title: RichText(
          text: TextSpan(
              text: "Rutuja ",
              style: GoogleFonts.cookie(
                fontSize: 25,
                color: Color.fromRGBO(219, 194, 164, 1),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: " & ",
                  style: GoogleFonts.cookie(
                    fontSize: 15,
                    color: Color.fromRGBO(219, 194, 164, 1),
                  ),
                ),
                TextSpan(
                  text: " Karan ",
                  style: GoogleFonts.cookie(
                    fontSize: 25,
                    color: Color.fromRGBO(219, 194, 164, 1),
                  ),
                ),
                TextSpan(
                  text: " - ",
                  style: GoogleFonts.cookie(
                    fontSize: 25,
                    color: Color.fromRGBO(219, 194, 164, 1),
                  ),
                ),
                TextSpan(
                  text: "Flea Market",
                  style: GoogleFonts.cookie(
                    fontSize: 30,
                    color: Color.fromRGBO(234, 87, 83, 1),
                  ),
                ),
              ]),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(25),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome Back,",
                style: GoogleFonts.muli(
                    color: Color.fromRGBO(234, 87, 83, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "${firebaseUser.displayName}",
                style: GoogleFonts.muli(
                    color: Color.fromRGBO(31, 31, 38, 1),
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    child: Image.asset("assets/Images/profile.png"),
                  ),
                  Transform.translate(
                    offset: Offset(-2, -3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(55),
                      child: Container(
                        width: 110,
                        height: 110,
                        color: Colors.white,
                        child: Image.asset(profileAvatar[avatarId]),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 140,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _overlay = true;
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color.fromRGBO(234, 87, 83, 0.9),
                            child: Icon(
                              Icons.settings_suggest_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(child: Container(),),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => CategorieScreen(
                                  firebaseUser.uid, "Your Products")));
                    },
                    child: ProfileOptions(
                        "Your Products", "assets/Images/your_product.png"),
                  ),
                  SizedBox(width: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => CartScreen()));
                    },
                    child:
                        ProfileOptions("Your Cart", "assets/Images/cart.png"),
                  ),
                  SizedBox(width: 50),
                  GestureDetector(
                     onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => PurchaseHistoryScreen()));
                    },
                    child: ProfileOptions(
                        "Purchase History", "assets/Images/purchase_history.png"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      clearCartOnLogout();
                      context.read<FirebaseAuthService>().signOut();
                      Navigator.pop(context);
                    },
                    child: Text("Logout?",
                        style: GoogleFonts.muli(
                            fontSize: 20,
                            color: Color.fromRGBO(31, 31, 38, 0.7),
                            fontWeight: FontWeight.w700)),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Color.fromRGBO(234, 87, 83, 0.8), width: 3),
                        primary: Color.fromRGBO(234, 87, 83, 1),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        )),
                  ),
                ),
              ),
            ],
          ),
          if (_overlay)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: height * 0.95,
                  width: width * 0.85,
                  padding: EdgeInsets.only(top: 100,bottom: 50,left: 100,right: 100),
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Choose an Avatar",
                                  style: GoogleFonts.muli(
                                      fontSize: 25,
                                      color: Color.fromRGBO(31, 31, 38, 0.8),
                                      fontWeight: FontWeight.w700)),
                              SizedBox(height: 50),
                              Container(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: profileAvatar
                                      .map((item) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              updateAvatarId(
                                                  profileAvatar.indexOf(item));
                                              _overlay = false;
                                            });
                                          },
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                              child: Image.asset(item))))
                                      .toList(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 50),
                                child: SizedBox(
                                  width: 150,
                                  height: 40,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _overlay = false;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color:
                                              Color.fromRGBO(31, 31, 38, 0.7),
                                          size: 20,
                                        ),
                                        Text("  Close",
                                            style: GoogleFonts.muli(
                                                fontSize: 17,
                                                color: Color.fromRGBO(
                                                    31, 31, 38, 0.7),
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color:
                                              Color.fromRGBO(234, 87, 83, 0.8),
                                          width: 2,
                                        ),
                                        primary: Color.fromRGBO(234, 87, 83, 1),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            )
        ], alignment: Alignment.center),
      ),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  final title;
  final image;
  ProfileOptions(this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: GoogleFonts.muli(
                    fontSize: 20,
                    color: Color.fromRGBO(234, 87, 83, 1),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  width: 75,
                  child: Image.asset(
                    image,
                    color: Color.fromRGBO(31, 31, 37, 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
