import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testgradle/pages/chat_page.dart';
import 'package:testgradle/pages/home_page.dart';
import 'package:testgradle/pages/login_page.dart';
import 'package:testgradle/pages/signup_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chat app',
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (context)=> const HomeScreen(),
        LoginScreen.route: (context)=> const LoginScreen(),
        SignUpScreen.route: (context)=> const SignUpScreen(),
        ChatScreen.route: (context)=> const ChatScreen(),

      },
    );
  }
}


