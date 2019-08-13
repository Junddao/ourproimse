import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc.dart';

class TabPage extends StatefulWidget {

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn =  GoogleSignIn();

    return StreamBuilder<UserInfoDetails>(
      stream: userInfoBloc.userInfoStream,
      builder: (context, snapshot) {
        UserInfoDetails userInfo;
        if(snapshot.hasData){
          userInfo = snapshot.data;
        }
        else
          userInfoBloc.addCurrentUserInfo;
        return Scaffold(
          appBar:  AppBar(
              // title:  Text(snapshot.data.userName),
              title: Text("test"),
              automaticallyImplyLeading: false,
              actions: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20.0,
                  color: Colors.white,
                ),
                onPressed: (){
                  
                   _gSignIn.signOut();
                  print('Signed out');
                   Navigator.pop(context);
                 
                },
              ),
            ],
            ),
          body: Center(child: 
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:NetworkImage(userInfo.photoUrl),
                  radius: 50.0,
                ),
                SizedBox(height:10.0),
                  Text(
                  "Name : " + userInfo.userName,
                  style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20.0),
                ),
                SizedBox(height:10.0),
                  Text(
                  "Email : " + userInfo.userEmail,
                  style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20.0),
                ),
                SizedBox(height:10.0),
                Text(
                  "Provider : " + userInfo.providerDetails,
                  style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20.0),
                ),
              ],
            ),),
          
            bottomNavigationBar: BottomNavigationBar(
              onTap: _onItemTapped,
                    currentIndex: _selectedIndex,
                    items : <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
                    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
                    BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Account')),
            
                  ]
                ),
              );
      }
    );
        }
        
        void _onItemTapped(int value) {
          _selectedIndex = value; 
          // setState(() {
          // _selectedIndex = value; 
          // }
          // );
  }
}
