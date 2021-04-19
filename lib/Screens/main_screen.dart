import 'package:flea_market/Screens/cart_screen.dart';
import 'package:flutter/services.dart';
import '../Widgets/testimonial.dart';

import './add_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '/authentication/app/services/firebase_auth_service.dart';
// import '../Widgets/dashboard.dart';
import '../Widgets/categorie_widget.dart';
import '../Screens/user_account.dart';
import './category_screen.dart';
import '../Widgets/acknowledgement.dart';
import '../Widgets/faq.dart';
import '../Widgets/home.dart';
import '../data.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.keyQ) {
      print('Pressed the "Q" key!');
      clearCartOnLogout();
      context.read<FirebaseAuthService>().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final height = MediaQuery.of(context).size.height;
    fetchAndSetProducts();
    fetchAndSetPurchasedProducts();
    fetchAndSetCartItems(firebaseUser);
    fetchAndSetAvatarID();

    return Scaffold(
      backgroundColor: Colors.white,
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: height,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
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
                  background: Container(
                    color: Colors.white,
                    child: Image.asset(
                      "assets/Images/AppBar-BG2.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      clearCartOnLogout();
                      context.read<FirebaseAuthService>().signOut();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  )
                ],
                backgroundColor: Color.fromRGBO(31, 31, 38, 1),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Home(),
                  //Dashboard(),
                  SizedBox(height: 100),

                  Center(
                    child: Text("Shop by Category",
                        style: GoogleFonts.muli(
                          fontSize: 40,
                          color: Color.fromRGBO(31, 31, 38, 0.8),
                        )),
                  ),
                  SizedBox(height: 75),
                ]),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 250),
                sliver: CategorieWidget(),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 50),
                  Column(
                    children: [
                      SizedBox(
                        width: 250,
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        CategorieScreen(null, "All Products")));
                          },
                          child: Text("View all products",
                              style: GoogleFonts.muli(
                                  fontSize: 20,
                                  color: Color.fromRGBO(31, 31, 38, 0.7),
                                  fontWeight: FontWeight.w700)),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: Color.fromRGBO(234, 87, 83, 0.8),
                                  width: 2),
                              primary: Color.fromRGBO(234, 87, 83, 1),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                ]),
              ),
              SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 200),
                  sliver: Testimonial()),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(height: 100),
                FAQ(),
                SizedBox(height: 100),
                Acknowledgement(),
                SizedBox(height: 10),
              ])),
            ],
          ),
        ),
      ),
      floatingActionButton: CircleFloatingButton.floatingActionButton(
        items: [
          FloatingActionButton(
            heroTag: "Cart",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => CartScreen()));
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.shopping_cart_outlined),
          ),
          FloatingActionButton(
            heroTag: "Add Product",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AddScreen()));
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.post_add_outlined),
          ),
          FloatingActionButton(
            heroTag: "Account",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => UserAccount()));
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.person),
          ),
        ],
        color: Color.fromRGBO(234, 87, 83, 1),
        icon: Icons.menu_rounded,
        duration: Duration(milliseconds: 500),
        curveAnim: Curves.ease,
      ),
    );
  }
}
