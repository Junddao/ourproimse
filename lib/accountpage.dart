import 'package:flutter/material.dart';
import 'bloc.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  UserInfoDetails userInfo;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserInfoDetails>(
      stream: userInfoBloc.userInfoStream,
      builder: (context, snapshot) {
        snapshot.hasData ? userInfo = snapshot.data : userInfo = userInfoBloc.addCurrentUserInfo;
        return Container(
          child : Center(
                  child: 
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
                    ),
                  ),
        );
      }
    );
  }
}