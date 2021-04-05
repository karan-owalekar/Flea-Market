import 'package:flutter/material.dart';

class Product {
  final String id;
  final String categorie;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String userId;

  const Product({
    @required this.id,
    @required this.categorie,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.userId,
  });
}
