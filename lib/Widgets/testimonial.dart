import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:google_fonts/google_fonts.dart';

class Testimonial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          elevation: 10,
          color: Color.fromRGBO(245, 245, 245, 1),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Images/testimonials.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "What Our Users Says",
                    style: GoogleFonts.muli(
                        fontSize: 25,
                        color: Color.fromRGBO(31, 31, 38, 0.8),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Our Users send us bunch of smilies with our service and we love them",
                  style: GoogleFonts.muli(
                      fontSize: 15,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 550,
                  child: CarouselSlider(
                    items: [
                      Center(
                        child: Text(
                          "Best buying and selling website for flea market shopping and selling.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.muli(
                              fontSize: 25,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Homemade products received the best cost after selling on this website. Got loyal customers.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.muli(
                              fontSize: 25,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Center(
                        child: Text(
                          "One of the best selling websites. I have got a lot of loyal customers.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.muli(
                              fontSize: 25,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                    options: CarouselOptions(
                      height: 300,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 1500),
                      viewportFraction: 1,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
