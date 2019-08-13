import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'tabpage.dart';


GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class UserInfoBloc{

  final userInfoController = StreamController<UserInfoDetails>.broadcast();
  get userInfoStream => userInfoController.stream;
  dispose(){
    userInfoController.close();
  }
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isLogin = false;
  
  Future<void> testSignInWithGoogle(BuildContext context) async {
    isLogin = true;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails = await _auth.signInWithCredential(credential);
    
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserInfoDetails details = new UserInfoDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    userInfoController.sink.add(details);
  }
}

var userInfoBloc = new UserInfoBloc();

class UserInfoDetails{
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserInfoDetails(this.providerDetails, this.userName, this.photoUrl, this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
