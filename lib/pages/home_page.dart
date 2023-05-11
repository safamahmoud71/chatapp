import 'package:flutter/material.dart';
import 'package:testgradle/pages/signup_page.dart';

import '../widgets/button.dart';
import 'login_page.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'Home_Screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset('assets/images/message.png', width: 250,),
            const Text('Chat App', style: TextStyle(
                color: Color(0xff323d5a)  ,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 20,),
            AppButton(
              title: 'Login',
              color: const Color(0xff74b4fd)  ,
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.route);
              },

            ),
            AppButton(
              title: 'Sign Up',
              color: const Color(0xff323d5a)  ,
              onPressed: (){
               Navigator.pushNamed(context, SignUpScreen.route);
              },

            ),
          ],
        ),

      ),

    );
  }
}

