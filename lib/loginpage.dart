
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourpromise/tabpage.dart';

import 'bloc.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                  'https://images.unsplash.com/photo-1518050947974-4be8c7469f0c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                  fit: BoxFit.fill,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  colorBlendMode: BlendMode.modulate),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                    width: 250.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: StreamBuilder<UserInfoDetails>(
                        stream: userInfoBloc.userInfoStream,
                        builder: (context, snapshot) {
                          return RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0)),
                                color: Color(0xffffffff),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.google,
                                      color: Color(0xffCE107C),
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  loginWithGoogle(context);
                                }
                                
                          );
                        }
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  loginWithGoogle(BuildContext context) {

    if(userInfoBloc.googleSignIn.currentUser == null) userInfoBloc.testSignInWithGoogle(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TabPage()));
  }
}
