import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/category_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/Images/HomePage.png"), context);
    precacheImage(AssetImage("assets/Images/HomeScreenEG.jpg"), context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 770,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/Images/HomePage.png"),
            fit: BoxFit.fitWidth),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 100),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "E-commerce",
                style: GoogleFonts.caveat(
                  color: Color.fromRGBO(234, 87, 83, 1),
                  fontSize: 40,
                ),
              ),
              Container(
                width: width / 2.5,
                child: Text(
                  "Start Your Business at ₹0.",
                  style: GoogleFonts.alatsi(
                    color: Colors.white,
                    fontSize: 80,
                  ),
                ),
              ),
              Container(
                width: 75,
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/Images/arrow.png",
                  fit: BoxFit.contain,
                  color: Colors.grey[600],
                ),
              ),
              Container(
                width: width / 4,
                child: Text(
                  "Search millions of unique items for sale in the world's largest flea market. Find everything vintage and antique in one online location.",
                  style: GoogleFonts.raleway(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromRGBO(234, 87, 83, 1),
                      Color.fromRGBO(255, 184, 142, 1),
                    ])),
                    child: OutlinedButton(
                      onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    CategorieScreen(null, "All Products")));
                      },
                      child: Text(
                        "All Products",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.all(125),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/Images/HomeScreenEG.jpg")),
          )
        ],
      ),
    );
  }
}
