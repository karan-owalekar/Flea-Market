import '/authentication/app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      onPressed: () {
        context.read<FirebaseAuthService>().signInWithGoogle();
      },
      text: "Sign in with Google",
    );
  }
}
