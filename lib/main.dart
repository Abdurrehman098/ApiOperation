import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_practice/provider/api_provider.dart';
import 'package:rest_api_practice/provider/auth_provider.dart';
import 'package:rest_api_practice/screens/auth/login.dart';

void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider(),),
        ChangeNotifierProvider(create: (context) => AuthProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         home: LoginScreen(),
      ),
    );
  }
}

