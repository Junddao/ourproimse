import 'dart:async';

class UserInfoBloc{

  UserInfoDetails details;

  final userInfoController = StreamController<UserInfoDetails>.broadcast();

  get userInfoStream => userInfoController.stream;
  // get addCurrentUserInfo => userInfoController.sink.add(details);
  get addCurrentUserInfo => details;

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


class TabStates{

  int selectedIndex = 0;

  final selectedIndexController = StreamController<int>.broadcast();

  get selectedIndexStream => selectedIndexController.stream;
  get addCurrentSelectedIndex => selectedIndexController.sink.add(selectedIndex);

  selectTab(int value)
  {
    selectedIndex = value;
    selectedIndexController.sink.add(selectedIndex);
  }

  dispose()
  {
    selectedIndexController.close();
  }
}

TabStates tabStates = new TabStates();
