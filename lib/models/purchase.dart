import 'package:flutter/material.dart';

class Purchase {
  final String time;
  final List<dynamic> products;
  final double amount;

  const Purchase({
    @required this.amount,
    @required this.products,
    @required this.time,
  });
}
