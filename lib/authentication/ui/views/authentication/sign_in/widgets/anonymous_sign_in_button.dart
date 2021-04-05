import '/authentication/app/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sign_in_view_model.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<SignInViewModel>().signInAnonymously();
      },
      style: ElevatedButton.styleFrom(primary: Colors.white),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.5,
            child: Image.asset(
              "assets/Images/anonymous.png",
              color: Colors.grey[800],
            ),
          ),
          Text(
            Strings.anonymousSignUp,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
