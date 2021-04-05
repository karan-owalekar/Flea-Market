import 'package:flutter/material.dart';

class Acknowledgement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.all(10),
      color: Color.fromRGBO(31, 31, 37, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Transform.translate(
            offset: Offset(20, 0),
            child: Text(
              "ʕ•́ᴥ•̀ʔっ",
              style: TextStyle(
                  fontSize: 45,
                  fontFamily: "ARIAL",
                  color: Color.fromRGBO(247, 118, 73, 1)),
            ),
          ),
          Text(
            "... w e b s i t e     m a d e     f r o m     s c r a t c h     b y     u s ...",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
