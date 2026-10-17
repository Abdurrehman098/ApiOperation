import 'package:flutter/material.dart';
import 'package:rest_api_practice/Api_services/userApi.dart';
import 'package:rest_api_practice/model/user_model.dart';
import 'package:rest_api_practice/screens/home_screen.dart';
import 'package:rest_api_practice/screens/profile_screen.dart';

class AuthProvider extends ChangeNotifier{
  bool isLoading  = false;
  final UserApi userApi =UserApi();
  UserModel? user;
  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    if (value.trim().length < 3) {
      return "Username must be at least 3 characters";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }






  Future<void>login(UserModel model, BuildContext context)async{
    try {
      isLoading =  true;
      notifyListeners();
     final user = await userApi.login(model);
     print("Username: ${user.username}");
   if(!context.mounted){
     return;
   }
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>HomeScreen() ,), (value)=> false);

      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>ProfileScreen(token : user.accessToken!) ,), (value)=> false
      // );

    }
    catch(e){
      throw Exception(e.toString());
    }
    finally{
      isLoading = false;
      notifyListeners();
    }

  }



Future<void>profile(String token , )async{
  try{
    isLoading = true;
    notifyListeners();
    final result = await userApi.profile(token);
    user = result;

  }
  catch(e){
throw Exception(e.toString());
  }
  finally{
    isLoading = false;
    notifyListeners();

  }
}
}