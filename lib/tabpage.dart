import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourpromise/accountpage.dart';
import 'package:ourpromise/searchPage.dart';
import 'package:ourpromise/writepage.dart';

import 'bloc.dart';

class TabPage extends StatefulWidget {

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _selectedIndex = 0;
  UserInfoDetails userInfo;

  final List<Widget> _tabs = [WritePage(), SearchPage(), AccountPage()];
  
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn =  GoogleSignIn();

    return StreamBuilder<UserInfoDetails>(
      stream: userInfoBloc.userInfoStream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          userInfo = snapshot.data;
        }
        else
          userInfo = userInfoBloc.addCurrentUserInfo;
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
              body: StreamBuilder<int>(
                stream: tabStates.selectedIndexStream,
                builder: (context, snapshot) {
                  snapshot.hasData ? _selectedIndex = snapshot.data : _selectedIndex = tabStates.addCurrentSelectedIndex;
                  return _tabs[snapshot.data];
                }
              ),
             
                
              bottomNavigationBar: StreamBuilder<Object>(
                stream: tabStates.selectedIndexStream,
                builder: (context, snapshot) {
                  snapshot.hasData ? _selectedIndex = snapshot.data : _selectedIndex = tabStates.addCurrentSelectedIndex;
                  return BottomNavigationBar(
                    onTap: _onItemTapped,
                      currentIndex:  _selectedIndex,
                      items : <BottomNavigationBarItem>[
                      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),  // 뭘 보여줘야 할까...
                      BottomNavigationBarItem(icon: Icon(Icons.border_color), title: Text('Write')),  // 계약서 작성 페이지  
                      BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Account')),  // 내 계정 확인, 작성 문서찾기
                      ]
                    );
                }
              ),
            );
          }
        );
      }
  
        
  void _onItemTapped(int value) {
    tabStates.selectTab(value);
  }
}
