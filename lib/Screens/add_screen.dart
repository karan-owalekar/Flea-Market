import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data.dart';
import '../models/product.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final snackBar = SnackBar(content: Text("Your product was added!"));
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  String category = "0";
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageURLController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                "Add your Product",
                style: GoogleFonts.muli(
                    fontSize: 30,
                    color: Color.fromRGBO(31, 31, 38, 1),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(50),
                width: 800,
                decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.circular(25)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Color.fromRGBO(234, 87, 83, 1),
                        style: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 87, 83, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 87, 83, 1)),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the Product Title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        cursorColor: Color.fromRGBO(234, 87, 83, 1),
                        style: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: "Description",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 87, 83, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 87, 83, 1)),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        "Choose a category",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 17,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: fetchAllCategories()
                            .map((item) => Row(children: [
                                  SizedBox(
                                    width: 10,
                                    child: Radio(
                                      value: item.id,
                                      groupValue: category,
                                      activeColor: Colors.orange,
                                      onChanged: (value) {
                                        //value may be true or false
                                        setState(() {
                                          category = item.id;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(item.title),
                                ]))
                            .toList(),
                      ),
                      SizedBox(height: 25),
                      SizedBox(height: 25),
                      Text(
                        "Enter image URL",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                      TextFormField(
                        cursorColor: Color.fromRGBO(234, 87, 83, 1),
                        style: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
                        controller: imageURLController,
                        decoration: InputDecoration(
                          labelText: "URL",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 87, 83, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 87, 83, 1)),
                          ),
                        ),
                        validator: (value) {
                          if (value.endsWith(".jpg") ||
                              value.endsWith(".png")) {
                          } else {
                            return 'Enter correct URL';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          cursorColor: Color.fromRGBO(234, 87, 83, 1),
                          style: TextStyle(
                              color: Color.fromRGBO(234, 87, 83, 1),
                              fontSize: 20),
                          controller: priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(234, 87, 83, 1)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(234, 87, 83, 1)),
                            ),
                          ),
                          validator: (value) {
                            if (double.tryParse(value) == null) {
                              return 'Enter a number!';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(234, 84, 89, 1)),
                            onPressed: () {
                              if (_formKey.currentState.validate() &&
                                  category != "0") {
                                addProduct(
                                    firebaseUser,
                                    firestoreInstance,
                                    Product(
                                      id: firebaseUser.uid,
                                      categorie: category,
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      price: double.parse(priceController.text),
                                      imageUrl: imageURLController.text,
                                      userId: "0",
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Add Product",
                                style: TextStyle(fontSize: 22)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
