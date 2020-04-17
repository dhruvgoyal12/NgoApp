import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngo/forgot.dart';
import 'package:ngo/login.dart';
import 'Tab1.dart';
import 'Tab2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'alertUser.dart';
import 'categories2.dart';

import 'package:firebase_auth/firebase_auth.dart';

class tab extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
              child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('AAS - To help whoever Breaths',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/wel11.jpg'),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Change Category'),
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Categories2()));
                },
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.autorenew),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Change Password'),
                    ),
                  ],
                ),
                onTap: () async {
                  try {
                    final loggedinUser = await _auth.currentUser();
                    final exist = await _auth
                        .fetchSignInMethodsForEmail(email: loggedinUser.email)
                        .toString();
                    if (exist != null) {
                      await _auth.sendPasswordResetEmail(
                          email: loggedinUser.email);
                      var alertDialog = AlertUser(
                        title: 'Success!',
                        content: 'Please check your email',
                        btnText: 'Back',
                      );
                      showDialog(
                          context: (context),
                          builder: (context) {
                            return alertDialog;
                          });
                    }
                  } catch (e) {
                    var alertDialog = AlertUser(
                      title: 'Oops',
                      content: 'An error occured. Please try later',
                      btnText: 'Back',
                    );
                    showDialog(
                        context: (context),
                        builder: (context) {
                          return alertDialog;
                        });
                  }
                },
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Logout'),
                    ),
                  ],
                ),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: LoginScreen()));
                },
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.delete),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Delete Account'),
                    ),
                  ],
                ),
                onTap: () async {
                  try {
                    final loggedinUser = await _auth.currentUser();
                    final QuerySnapshot result = await _firestore
                        .collection('categories')
                        .where('sender',
                            isEqualTo: loggedinUser.email.toLowerCase())
                        .limit(1)
                        .getDocuments();

                    String id;
                    for (var r in result.documents) {
                      id = r.documentID;
                    }

                    await _firestore
                        .collection('categories')
                        .document(id)
                        .delete();

                    await loggedinUser.delete();

                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: LoginScreen()));
                  } catch (e) {
                    print(e);
//                    var alertDialog = AlertUser(
//                      title: 'Oops!',
//                      content:
//                          'We cannot reach our servers right now. Please check your internet connection',
//                      btnText: 'Back',
//                    );
//                    showDialog(
//                        context: (context),
//                        builder: (context) {
//                          return alertDialog;
//                        });
                  }
                },
              ),
            ],
          )),
          appBar: AppBar(
            backgroundColor: Colors.black87,
            bottom: TabBar(
              tabs: [
                Container(
                    height: 53.0,
                    child: Tab(text: 'New', icon: Icon(Icons.add_alert))),
                Container(
                    height: 53.0,
                    child: Tab(text: 'Pending', icon: Icon(Icons.access_time))),
              ],
            ),
            title: Text('AAS'),
          ),
          body: Container(
            child: TabBarView(
              children: [Tab1(), Tab2()],
            ),
          ),
        ),
      ),
      //initialRoute: MyApp.id,
//        routes: {
//          //detailed_view.id:(context) => detailed_view(),
//          Tab1.id: (context) => Tab1(),
//          Tab2.id: (context) => Tab2(),
//          MyApp.id: (context) => MyApp(),
//        },
    );
  }
}
