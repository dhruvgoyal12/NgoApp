import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngo/Roundedbutton.dart';
import 'package:ngo/rounded_button.dart';

class detailed_view extends StatelessWidget {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String loggedInUser;
  DocumentSnapshot document;
  static String id = "detailed_view";

  detailed_view({Key key, @required this.document, this.loggedInUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String address = document.data['address'],
        note = document.data['note'],
        time = document.data['time'],
        img_url = document.data['img_url'],
        location = document.data['city'],
        submitted_by = document.data['submitted_by'],
        submitter_phone_no = document.data['submitter_phone_no'],
        category = document.data['category'];
    return Scaffold(
      backgroundColor: Colors.white30,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 10.0,
              child: Image.network(
                img_url,
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      elevation: 10.0,
                      color: Colors.white30.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('$note.\n',
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                  fontSize: 17.0,
                                )),
                            Text(time,
                                style: TextStyle(
                                  color: Colors.white70,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
//            Container(
//                height: 1.0,
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey,
//                    width: 1.4,
//                  ),
//                )),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                elevation: 10.0,
                color: Colors.white30.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Address: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 17.0,
                          )),
                      Expanded(
                        child: Text(address,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17.0,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                elevation: 10.0,
                color: Colors.white30.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Text("Submitted by: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 17.0,
                          )),
                      Expanded(
                        child: Text(submitted_by,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17.0,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                elevation: 10.0,
                color: Colors.white30.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Text("Phone NO. ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 17.0,
                          )),
                      Expanded(
                          child: Text(submitter_phone_no,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 17.0,
                              )))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: rounded_button(
                        onPressed: () {
                          _firestore.collection('requests_accepted').add({
                            'img_url': img_url,
                            'city': location,
                            'address': address,
                            'note': note,
                            'time': time,
                            'submitted_by': submitted_by,
                            'submitter_phone_no': submitter_phone_no,
                            'accepted_by': loggedInUser,
                            'category': category,
                          });
                          document.reference.delete();
                          Navigator.pop(context);
                        },
                        text: ("Accept"),
                        color: Colors.lightGreen
//                      color: Colors.green,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0)),
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
