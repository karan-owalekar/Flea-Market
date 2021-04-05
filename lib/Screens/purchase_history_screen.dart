import 'package:flea_market/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/purchase.dart';
import '../models/product.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  @override
  _PurchaseHistoryScreenState createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  List<Purchase> myPurchases = getMyPurchases();

  Purchase _currentPurchase = getLatestPurchase();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
      backgroundColor: Colors.grey[50],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: width,
              child: Image.asset("assets/Images/purchaseBG.png",
                  fit: BoxFit.fitWidth)),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
                width: width * 0.7,
                child: Image.asset("assets/Images/purchaseOverlayBG.png",
                    fit: BoxFit.fitWidth)),
          ),
          Container(
            width: width * 0.6,
            height: height * 0.6,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "My Purchases",
                    style: GoogleFonts.muli(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: myPurchases.length == 0
                            ? [Text("No purchase made yet!",style: GoogleFonts.muli(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),)]
                            : myPurchases
                                .map((item) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _currentPurchase = myPurchases
                                                .firstWhere((element) =>
                                                    element.time == item.time);
                                          });
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: PurchasedProductTile(
                                              item.amount,
                                              item.time,
                                              item.products.length,
                                              _currentPurchase.time),
                                        ),
                                      ),
                                    ))
                                .toList(),
                      ),
                    ),
                  ),
                ),
                if (myPurchases.length != 0)
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width * 0.5,
                    height: height * 0.3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 3, color: Colors.grey[200]))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Purchase Details:",
                                  style: GoogleFonts.muli(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    width: width * 0.2,
                                    height: height * 0.15,
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey[50],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "₹${_currentPurchase.amount}",
                                          style: GoogleFonts.muli(
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  31, 31, 38, 0.8),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          DateFormat('d MMM yyyy, hh:mm a')
                                              .format(DateTime.parse(
                                                  _currentPurchase.time)),
                                          style: GoogleFonts.muli(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Container(
                            padding: EdgeInsets.only(top: 25, left: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  child: Text(
                                    "Products:",
                                    style: GoogleFonts.muli(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: _currentPurchase.products
                                            .map((item) => ProductTile(item))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PurchasedProductTile extends StatelessWidget {
  final amount;
  final time;
  final totalProducts;
  final currentPurchase;
  PurchasedProductTile(
      this.amount, this.time, this.totalProducts, this.currentPurchase);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "₹$amount",
                style: GoogleFonts.muli(
                    fontSize: 25,
                    color: Color.fromRGBO(234, 87, 83, 1),
                    fontWeight: FontWeight.w700),
              ),
              Text(
                DateFormat('EEEE, d MMM').format(DateTime.parse(time)),
                style: GoogleFonts.muli(
                    fontSize: 17,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w600),
              ),
              Expanded(child: Container()),
              Text(
                totalProducts.toString() == "1"
                    ? "Purchased $totalProducts product"
                    : "Purchased $totalProducts products",
                style: GoogleFonts.muli(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10),
              if (currentPurchase == time)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      Colors.redAccent,
                      Colors.white,
                    ]),
                  ),
                  height: 2,
                  width: 150,
                )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final id;
  ProductTile(this.id);
  @override
  Widget build(BuildContext context) {
    Product _product = getProduct(id);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          height: 50,
          width: 50,
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        _product.title,
        style: GoogleFonts.muli(),
      ),
      subtitle: Text(
        _product.description,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        "₹${_product.price}",
        style: GoogleFonts.muli(fontWeight: FontWeight.w700),
      ),
    );
  }
}
