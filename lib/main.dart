import 'package:firebase_blogger/pages/login_page.dart';
import 'package:flutter/material.dart';
import './pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blogger',
            theme: ThemeData(
              primarySwatch: Colors.lightGreen,
              canvasColor: Colors.lightGreen.shade50,
              bottomAppBarColor: Colors.lightGreen,
            ),
            home: Login(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }

  Widget SomethingWentWrong() {
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blogger',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        canvasColor: Colors.lightGreen.shade50,
        bottomAppBarColor: Colors.lightGreen,
      ),
      home: Scaffold(
        body: Center(
          child: Text('some thing went wrong try restarting the app'),
        ),
      ),
    );
  }

  Widget Loading() {
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blogger',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        canvasColor: Colors.lightGreen.shade50,
        bottomAppBarColor: Colors.lightGreen,
      ),
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
