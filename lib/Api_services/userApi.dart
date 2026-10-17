import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_api_practice/model/user_model.dart';

class UserApi {


  String baseUrl = "https://dummyjson.com";

  Future<UserModel>login(UserModel model)async{
   try{
     final response = await http.post(Uri.parse("$baseUrl/auth/login"),
       headers: {
         "content-Type" : "Application/json"
       },
       body: jsonEncode(model.toJson()),
     );
     if(response.statusCode == 200){
       final data  = jsonDecode(response.body);
       return UserModel.fromJson(data);

     }
     else{
       throw Exception("authentication failed ${response.statusCode}");
     }

   }
   catch (e){
     throw Exception("Error : $e");
   }

  }

  Future<UserModel>profile(String token)async{

  try{

final response = await http.get(Uri.parse("$baseUrl/auth/me"),
  headers: {
    "Authorization": "Bearer $token",
  },
);
    if(response.statusCode==200){
    final data = jsonDecode(response.body);
    return UserModel.fromJson(data);
    }
    else{
    throw Exception("Error : ${response.statusCode}");
    }
  }
  catch(e){
    throw Exception("Error : $e");

  }

  }






}