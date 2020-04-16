import 'package:flutter/material.dart';
import 'Tab1.dart';
import 'Tab2.dart';

class tab extends StatelessWidget {
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
                onTap: () {
                  Navigator.pop(context);
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
                onTap: () {
                  Navigator.pop(context);
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
                onTap: () {
                  Navigator.pop(context);
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
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )),
          appBar: AppBar(
            backgroundColor: Colors.black87,
            bottom: TabBar(
              tabs: [
                Tab(text: 'New', icon: Icon(Icons.add_alert)),
                Tab(text: 'Pending', icon: Icon(Icons.access_time)),
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
