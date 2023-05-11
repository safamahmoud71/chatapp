import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testgradle/pages/chat_page.dart';

import '../widgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class SignUpScreen extends StatefulWidget {
  static const String route = 'signup_screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String pass;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/message.png', width: 150,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,

                    onChanged: (value){
                      email = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Email',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),
                      enabledBorder: OutlineInputBorder(

                        borderSide: BorderSide(color:Color(0xff323d5a), width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),
                      focusedBorder: OutlineInputBorder(

                        borderSide: BorderSide(color:Color(0xff74b4fd), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),

                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value){
                      pass=value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Your password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),
                      enabledBorder: OutlineInputBorder(

                        borderSide: BorderSide(color:Color(0xff323d5a), width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),
                      focusedBorder: OutlineInputBorder(

                        borderSide: BorderSide(color:Color(0xff74b4fd), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),

                      ),

                    ),

                  ),
                ),

                AppButton(
                  color: const Color(0xff74b4fd),
                  onPressed: () async{

                    setState(() {
                      showSpinner = true;
                    });

                    //sync ---->methods happen in the same time
                    // async---->not in the same time
               try{
                 final newUser =  await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                 showSpinner = false;
                 Navigator.pushNamed(context, ChatScreen.route);
               }
               catch(error){
                 print(error);
               }
                   },
                  title: 'Signup',
                )

              ],
            ),
          ),
        ),
      )
    );
  }
}
