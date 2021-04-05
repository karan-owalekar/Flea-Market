import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data.dart';
import '../models/product.dart';
import '../Widgets/product_box.dart';

class CategorieScreen extends StatefulWidget {
  final _id;
  final title;
  CategorieScreen(this._id, this.title);

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  // ignore: avoid_init_to_null
  var overlayProductId = null;
  Product zoomProduct;
  final snackBar = SnackBar(content: Text("Product added to the cart!"));

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
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                if (widget._id != null && widget._id != firebaseUser.uid)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: DUMMY_CATEGORIES
                          .map((item) => ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => CategorieScreen(
                                                item.id, item.title)));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 130,
                                    color: item.id == widget._id
                                        ? Colors.grey[900]
                                        : Colors.white,
                                    child: Center(
                                        child: Text(
                                      item.title,
                                      style: GoogleFonts.roboto(
                                        color: item.id == widget._id
                                            ? Colors.white
                                            : Colors.grey[900],
                                      ),
                                    )),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.istokWeb(
                          fontSize: 50,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "${(widget._id == null ? fetchAllProducts() : widget._id == firebaseUser.uid ? fetchYourProducts(firebaseUser.uid) : fetchProducts(widget._id)).map((item) => ProductBox(item)).toList().length} items",
                    style: GoogleFonts.istokWeb(
                        fontSize: 20,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 50),
                Wrap(
                    spacing: 25,
                    runSpacing: 25,
                    children: (widget._id == null
                            ? fetchAllProducts()
                            : widget._id == firebaseUser.uid
                                ? fetchYourProducts(firebaseUser.uid)
                                : fetchProducts(widget._id))
                        .map(
                          (item) => GestureDetector(
                            child: ProductBox(item),
                            onTap: () {
                              setState(() {
                                overlayProductId = item.id;
                                zoomProduct = getProduct(item.id);
                              });
                            },
                          ),
                        )
                        .toList()),
              ],
            ),
            if (overlayProductId != null)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: height * 0.85,
                    width: width * 0.85,
                    padding: EdgeInsets.all(100),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.85,
                              child: Image.network(
                                zoomProduct.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          overlayProductId = null;
                                          zoomProduct = null;
                                        });
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_back,
                                              color:
                                                  Color.fromRGBO(31, 31, 38, 1),
                                            ),
                                            Text(
                                              "  Close",
                                              style: GoogleFonts.muli(
                                                  color: Color.fromRGBO(
                                                      31, 31, 38, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 50),
                                    Container(
                                      width: width * 0.2,
                                      child: Text(
                                        zoomProduct.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.muli(
                                            fontSize: 30,
                                            color: Colors.grey[900]),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: width * 0.2,
                                      child: Text(
                                        zoomProduct.description,
                                        style: GoogleFonts.muli(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "₹ ${zoomProduct.price}",
                                      style: GoogleFonts.muli(
                                          fontSize: 40,
                                          color: Colors.grey[900]),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    addToCartItems(zoomProduct.id);
                                    addToCart(
                                      firebaseUser,
                                      firestoreInstance,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    setState(() {
                                      overlayProductId = null;
                                      zoomProduct = null;
                                    });
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: 60,
                                        width: 200,
                                        color: Color.fromRGBO(31, 31, 38, 1),
                                        child: Center(
                                          child: Text(
                                            "Add to Cart",
                                            style: GoogleFonts.muli(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
