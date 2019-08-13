import 'package:flutter/material.dart';
import 'package:ourpromise/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TabPage extends StatefulWidget {
  TabPage({Key key, @required this.detailsUser}) : super(key: key);

  final UserDetails detailsUser;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn =  GoogleSignIn();

    return Scaffold(
      appBar:  AppBar(
          title:  Text(widget.detailsUser.userName),
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
              backgroundImage:NetworkImage(widget.detailsUser.photoUrl),
              radius: 50.0,
            ),
            SizedBox(height:10.0),
              Text(
              "Name : " + widget.detailsUser.userName,
              style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20.0),
            ),
            SizedBox(height:10.0),
              Text(
              "Email : " + widget.detailsUser.userEmail,
              style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20.0),
            ),
            SizedBox(height:10.0),
            Text(
              "Provider : " + widget.detailsUser.providerDetails,
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
        
        void _onItemTapped(int value) {
          setState(() {
          _selectedIndex = value; 
          }
        );
  }
}
