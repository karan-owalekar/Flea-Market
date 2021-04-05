import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        dashboardItems("1 million Buyers", Icons.shopping_bag_outlined),
        dashboardItems("2 million Accounts", Icons.account_circle),
        dashboardItems("272K Sellers", Icons.hail),
      ],
    );
  }

  Stack dashboardItems(text, icon) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(0, 100),
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Color.fromRGBO(247, 118, 73, 1),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Transform.translate(
                offset: Offset(0, 25),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(75),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Color.fromRGBO(234, 84, 89, 1),
                border: Border.all(
                    color: Color.fromRGBO(247, 118, 73, 1), width: 3)),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 75,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
