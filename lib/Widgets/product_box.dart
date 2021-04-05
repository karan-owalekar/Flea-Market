import 'package:flutter/material.dart';
import '../models/product.dart';

// ignore: must_be_immutable
class ProductBox extends StatelessWidget {
  Product item;
  ProductBox(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 250,
                width: 200,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 5),
              child: Text(
                item.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.only(top: 5, bottom: 7, left: 10, right: 5),
              child: Text(
                "₹${item.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.grey[600]),
              ),
            ),
          ],
        ));
  }
}
