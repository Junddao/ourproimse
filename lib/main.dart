import 'dart:async';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() {
  runApp(
    new MaterialApp(
      title: 'Google Sign In',
      home: new SignInDemo(),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => new _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {

  String userText;

  Future<String> testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print(currentUser.uid);
    setState(() {
      userText = currentUser.uid;
    });
    return 'signInWithGoogle succeeded: $user';
  }

  Future<Null> handleSignOut() async {
    await FirebaseAuth.channel.invokeMethod("signOut");
    final FirebaseUser currentUser = await _auth.currentUser();
    setState(() {
      userText = currentUser.uid;
    });
  }

  Future<Null> getUid() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    print(currentUser);
    setState(() {
      userText = currentUser.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  child: new Text("Sign Google "),
                  color: Colors.redAccent,
                  onPressed: testSignInWithGoogle,
                ),
                new RaisedButton(
                  child: new Text("SignOut"),
                  color: Colors.orangeAccent,
                  onPressed: handleSignOut,
                )
              ],
            ),
            userText == null ? new Text("Null") : new Text(userText),
          ],
        )),
      ),
    );
  }
}
