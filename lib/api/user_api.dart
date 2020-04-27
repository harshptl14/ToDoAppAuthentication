import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sharing_content/models/user.dart';
import 'package:sharing_content/notifiers/auth_notifier.dart';

var userId;

login(User user, AuthNotifier authNotifier) async {
  var response = await http.get('http://10.0.2.2:8000/users/auth/' +
      user.email +
      '/' +
      user.password); //calling the api to get id of user
  print('after get');
  if (response.statusCode == 200 && response.body != "no user found") {
    //true if user loggedin successfully
    print('true condition');
    userId = response.body.toString(); // storing the id to variable->userid
    print(response.body.toString());
    //st=Status.Authenticated;
    if (userId != null) {
      print("Login : $userId");
      authNotifier.setUser(userId);
    }
  }
}

signup(User user, AuthNotifier authNotifier) async {
  var response = await http.post('http://10.0.2.2:8000/users/input/' + user.id,
      body: jsonEncode(user.toMap())); //calling api to store data of new user

      //   var response = await http.post('http://10.0.2.2:8000/users/input/$user.id',
// body: jsonEncode(user.toMap()));       //This type of declaration was showing error, so i separated (user.id) as shown up, I don't that it works or not.

  if (response.statusCode == 200 && response.body == "user saved") {
    //true if user registered successfully
    userId = user.id;

    if (userId != Null) {
      authNotifier.setUser(userId);
    }
    return true;
  }
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  String user = await userId;

  if (user != null) {
    print(user);
    authNotifier.setUser(user);
  }
}

signout(AuthNotifier authNotifier) async {
  userId = null;
  authNotifier.setUser(null);
}
