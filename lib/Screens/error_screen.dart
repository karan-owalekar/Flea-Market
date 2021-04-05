import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = "error-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        color: Colors.redAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 75,
            ),
            Text(
              "This website is not supported for mobile devices!",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(height: 10),
            Text(
              "Also, dont be oversmart and turn on desktop mode...",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
