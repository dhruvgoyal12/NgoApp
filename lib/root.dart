import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngo/afterRegister.dart';
import 'login.dart';
import 'authentication.dart';
import 'tab.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final Auth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  FirebaseUser loggedinUser;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.auth.currentUser().then((user) {
      getCurrentUser();
      setState(() {
        _authStatus =
            user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return LoginScreen(
          auth: widget.auth,
          onSignedin: _signedIn,
        );
      case AuthStatus.signedIn:
        return tab(
          loggedinUser: loggedinUser,
        );
    }
  }
}
