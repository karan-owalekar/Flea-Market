import 'package:flea_market/Screens/error_screen.dart';

import '/authentication/ui/views/authentication/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../Screens/main_screen.dart';

import 'models/user.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flea Market',
        theme: ThemeData(
          primarySwatch: MaterialColor(
            0xFFea5753,
            <int, Color>{
              50: Color(0xFFea5753),
              100: Color(0xFFea5753),
              200: Color(0xFFea5753),
              300: Color(0xFFea5753),
              400: Color(0xFFea5753),
              500: Color(0xFFea5753),
              600: Color(0xFFea5753),
              700: Color(0xFFea5753),
              800: Color(0xFFea5753),
              900: Color(0xFFea5753),
            },
          ),
        ),
        home: ScreenTypeLayout(
          desktop: Consumer<UserModel>(
            builder: (_, user, __) {
              if (user == null) {
                return SignInView();
              } else {
                return MainScreen();
              }
            },
          ),
          tablet: ErrorScreen(),
          mobile: ErrorScreen(),
        ));
  }
}
