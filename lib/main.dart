
import 'package:flutter/material.dart';
import '/authentication/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'authentication/app/app.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => FirebaseAuthService(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthService>().onAuthStateChanged,
          initialData: null,
        )
      ],
      child: MyApp(
        
      )
    ),
  );
}
