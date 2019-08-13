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

  UserInfoDetails details;

  final userInfoController = StreamController<UserInfoDetails>.broadcast();

  get userInfoStream => userInfoController.stream;

  get addCurrentUserInfo => userInfoController.sink.add(details);

  addToUserInfo(UserInfoDetails userInfo){
    details = userInfo;
    userInfoController.sink.add(details);
  }

  dispose(){
    userInfoController.close();
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
