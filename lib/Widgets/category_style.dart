import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/category_screen.dart';

class CategorieStyle extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String descrioption;

  CategorieStyle(this.id, this.title, this.image,this.descrioption);

  @override
  _CategorieStyleState createState() => _CategorieStyleState();
}

class _CategorieStyleState extends State<CategorieStyle> {
  var _hover = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) =>
                        CategorieScreen(widget.id, widget.title)));
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (_) {
              setState(() {
                _hover = true;
              });
            },
            onExit: (_){
              setState(() {
                _hover = false;
              });
            },
            child: Card(
              shadowColor: _hover?Color.fromRGBO(234, 87, 83, 0.7):null,
              elevation:_hover?10:1 ,
              
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 75,
                    height: 75,
                    child: Image.asset(
                      widget.image,
                      color: Color.fromRGBO(234, 87, 83, 1),
                    ),
                  ),
                  Text(
                    widget.title,
                    style: GoogleFonts.muli(
                      fontSize: 16,
                      color: Color.fromRGBO(31, 31, 38, 0.8),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Text(
                      widget.descrioption,
                      style: GoogleFonts.muli(
                        fontSize: 14,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Transform.translate(
                      offset: Offset(100, 0),
                      child:
                          Icon(Icons.arrow_forward, color: Colors.green[300]))
                ],
              ),
            ),
          )),
    );
  }
}