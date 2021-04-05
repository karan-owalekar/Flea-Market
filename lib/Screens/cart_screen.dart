import 'package:flea_market/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/product_box.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final firebaseUser = FirebaseAuth.instance.currentUser;

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.category,
                        color: Color.fromRGBO(31, 31, 38, 1),
                        size: 60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Confirm and Pay",
                          style: GoogleFonts.muli(
                              fontSize: 30,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w700)),
                    ),
                    Text("${cartItems.length} items",
                        style: GoogleFonts.muli(
                            fontSize: 15,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 50),
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 50),
                              Wrap(
                                spacing: 25,
                                runSpacing: 25,
                                children: getProductsFromCart()
                                    .map((item) => Stack(
                                          children: [
                                            ProductBox(item),
                                            Positioned(
                                              left: 160,
                                              top: 275,
                                              child: GestureDetector(
                                                onTap: () {
                                                  cartItems.remove(item.id);
                                                  addToCart(firebaseUser,
                                                      firestoreInstance);
                                                  setState(() {});
                                                },
                                                child: MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: CircleAvatar(
                                                    radius: 21,
                                                    backgroundColor:
                                                        Colors.grey[50],
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 3, color: Colors.grey[100]))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: width * 0.3,
                          height: 100,
                          padding: EdgeInsets.all(10),
                          color: Colors.grey[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email id",
                                style: GoogleFonts.muli(
                                    fontSize: 20,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.alternate_email,
                                    color: Color.fromRGBO(234, 87, 83, 1),
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    firebaseUser.email,
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: width * 0.3,
                          height: 200,
                          padding: EdgeInsets.all(10),
                          color: Colors.grey[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shopping information",
                                style: GoogleFonts.muli(
                                    fontSize: 20,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color.fromRGBO(234, 87, 83, 1),
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    firebaseUser.displayName,
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Color.fromRGBO(234, 87, 83, 1),
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    child: Text(
                                      "404, Your address not found!",
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.muli(
                                          fontSize: 18,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Color.fromRGBO(234, 87, 83, 1),
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "9999999999",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: width * 0.3,
                          height: 150,
                          padding: EdgeInsets.all(10),
                          color: Colors.grey[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment",
                                style: GoogleFonts.muli(
                                    fontSize: 20,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.credit_card,
                                    color: Color.fromRGBO(234, 87, 83, 1),
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "1111 2222 3333 4444          12/21          xxx",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: Color.fromRGBO(234, 87, 83, 1),
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Use shopping address",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: width * 0.3,
                          height: 130,
                          padding: EdgeInsets.all(10),
                          color: Colors.grey[100],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sub-total",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "₹${getTotal()}",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Taxes",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Free",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: GoogleFonts.muli(
                                        fontSize: 20,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "₹${getTotal()}",
                                    style: GoogleFonts.muli(
                                        fontSize: 20,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          if (getTotal() != 0) {
                            purchaseProducts(firebaseUser, firestoreInstance,
                                DateTime.now().toString());
                            fetchAndSetPurchasedProducts();
                            removeFromCart(firebaseUser, firestoreInstance);
                            
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              title: 'Purchased!',
                              desc: "",
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: () {},
                            )..show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.ERROR,
                              title: 'Error',
                              desc: "No products in the cart!",
                              btnOkOnPress: () {},
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red,
                              onDissmissCallback: () {},
                            )..show();
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 50,
                            width: width * 0.13,
                            color: Color.fromRGBO(234, 87, 83, 1),
                            child: Center(
                              child: Text(
                                "PLACE ORDER",
                                style: GoogleFonts.muli(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   AwesomeDialog(
      //     context: context,
      //     animType: AnimType.SCALE,
      //     headerAnimationLoop: false,
      //     dialogType: DialogType.SUCCES,
      //     title: 'Purchased!',
      //     desc: "",
      //     btnOkOnPress: () {
      //       Navigator.pop(context);
      //     },
      //     btnOkIcon: Icons.check_circle,
      //     onDissmissCallback: () {},
      //   )..show();
      // }),
    );
  }
}
