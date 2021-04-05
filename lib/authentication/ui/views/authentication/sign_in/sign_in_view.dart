import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/authentication/ui/views/authentication/sign_in/sign_in_view_model.dart';
//import '/authentication/ui/views/authentication/sign_in/widgets/anonymous_sign_in_button.dart';
import '/authentication/ui/views/authentication/sign_in/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: SignInViewBody._(),
        );
      },
    );
  }
}

class SignInViewBody extends StatelessWidget {
  const SignInViewBody._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((SignInViewModel viewModel) => viewModel.isLoading);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 184, 142, 1),
              Color.fromRGBO(234, 87, 83, 1),
            ]),
          ),
        ),
        Center(child: isLoading ? _loadingIndicator() : SignInWidget()),
      ],
    );
  }

  Center _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

// ignore: must_be_immutable
class SignInWidget extends StatelessWidget {
  String email, password;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final snackBar = SnackBar(
      content:
          Text("乁(ツ゚)ㄏ Try remembering your password... We won't help you!"));
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/Images/SignUp-BG.png"), context);
    final width = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white,
      shadowColor: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 200),
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          if (width > 1260)
            Expanded(
              flex: 55,
              child: ClipRRect(
                child: Image.asset("assets/Images/SignUp-BG.png"),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
            ),
          Expanded(
            flex: 45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 250,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(234, 87, 83, 1),
                            Color.fromRGBO(255, 184, 142, 1),
                          ]),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Text(
                        "Welcome  Back",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: InputForm(emailController, passwordController,
                        userNameController)),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () =>
                      ScaffoldMessenger.of(context).showSnackBar(snackBar),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    color: Colors.grey[400],
                    width: 100,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "or",
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    width: 100,
                    height: 1,
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SignInButton(GoogleSignInButton()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController userNameController;
  InputForm(
      this.emailController, this.passwordController, this.userNameController);
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  bool _signUpMode = false;
  String email, password, userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            _signUpMode ? "CREATE A NEW ACCOUNT" : "LOGIN YOUR ACCOUNT",
            style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(234, 87, 83, 1),
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        if (_signUpMode)
          SizedBox(
            width: 300,
            height: 50,
            child: TextFormField(
              controller: widget.userNameController,
              cursorColor: Color.fromRGBO(234, 87, 83, 1),
              style: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Color.fromRGBO(234, 87, 83, 0.8),
                ),
                hintText: "User Name",
                hintStyle: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(234, 87, 83, 1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(234, 87, 83, 1)),
                ),
              ),
            ),
          ),
        SizedBox(
          width: 300,
          height: 50,
          child: TextFormField(
            controller: widget.emailController,
            cursorColor: Color.fromRGBO(234, 87, 83, 1),
            style: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Color.fromRGBO(234, 87, 83, 0.8),
              ),
              hintText: "Email",
              hintStyle: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(234, 87, 83, 1)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(234, 87, 83, 1)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 300,
          height: 50,
          child: TextFormField(
            controller: widget.passwordController,
            obscureText: true,
            onFieldSubmitted: _signUpMode
                ? (_) {
                    email = widget.emailController.text;
                    password = widget.passwordController.text;
                    userName = widget.userNameController.text;
                    context
                        .read<SignInViewModel>()
                        .signUpWithEmailAndPassword(email, password, userName);
                    firestoreInstance
                        .collection("userAvatar")
                        .doc(firebaseUser.uid)
                        .set({"avatar": 0});
                  }
                : (_) {
                    email = widget.emailController.text;
                    password = widget.passwordController.text;
                    context
                        .read<SignInViewModel>()
                        .signInWithEmailAndPassword(email, password);
                  },
            cursorColor: Color.fromRGBO(234, 87, 83, 1),
            style: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Color.fromRGBO(234, 87, 83, 0.8),
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: Color.fromRGBO(234, 87, 83, 1)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(234, 87, 83, 1)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(234, 87, 83, 1)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(234, 87, 83, 1),
                Color.fromRGBO(255, 184, 142, 1),
              ])),
              child: OutlinedButton(
                onPressed: _signUpMode
                    ? () {
                        email = widget.emailController.text;
                        password = widget.passwordController.text;
                        userName = widget.userNameController.text;
                        context
                            .read<SignInViewModel>()
                            .signUpWithEmailAndPassword(
                                email, password, userName);
                        firestoreInstance
                            .collection("userAvatar")
                            .doc(firebaseUser.uid)
                            .set({"avatar": 0});
                      }
                    : () {
                        email = widget.emailController.text;
                        password = widget.passwordController.text;
                        context
                            .read<SignInViewModel>()
                            .signInWithEmailAndPassword(email, password);
                      },
                child: Text(
                  _signUpMode ? "SIGN UP" : "LOGIN",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _signUpMode = !_signUpMode;
            });
          },
          child:
              Text(_signUpMode ? "Already have an account?" : "Create account?",
                  style: TextStyle(
                    color: Color.fromRGBO(234, 87, 83, 0.9),
                    fontWeight: FontWeight.w500,
                  )),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class SignInButton extends StatelessWidget {
  Widget child;
  SignInButton(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
      width: 200,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(255, 184, 142, 1),
          ),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
