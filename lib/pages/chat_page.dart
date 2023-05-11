import 'package:flutter/material.dart';
import 'package:testgradle/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


late  User signedUser;//typer user come from firebase

class ChatScreen extends StatefulWidget {
  static const String route = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

     String? message ;
     final textController = TextEditingController();
     final firestore = FirebaseFirestore.instance;

  @override
  void initState()
  {
     super.initState();
     currentUser();
  }
  void currentUser ()
  {
    try{
      final user = _auth.currentUser;
      if(user!=null)
      {
        signedUser = user;
      }

    }catch(error)
    {
      print(error);
    }

  }


 // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff74b4fd)  ,
        title: Row(
          children: [
            Image.asset('assets/images/message.png', width: 40,),
            const SizedBox(width: 10,),
            const Text('Chat App', style: TextStyle(
                color: Colors.white  ,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),


          ],
        ),
        actions: [
          IconButton(onPressed:(){
            _auth.signOut();
            Navigator.pop(context);

          },
              icon:const Icon( Icons.exit_to_app_rounded))
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, HomeScreen.route);

          },
          icon: const Icon(Icons.arrow_back_ios_outlined),

        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:   [
            MessageStreamBuilder(firestore: firestore),
            Container(
             decoration: const BoxDecoration(
               border: Border(
                 top: BorderSide(
                     width: 2,
                     color: Color(0xff74b4fd)
                 ),

               )
             ),
           child: Row(
             children: [
               Expanded(
                 child: TextField(
                   controller: textController,
                   onChanged: (value){
                     message=value;
                   },
                   decoration: const InputDecoration(
                     contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                     hintText: 'Write your message ....',
                     border: InputBorder.none
                   ),
                 ),
               ),
               TextButton(onPressed: (){
                 textController.clear();
                 firestore.collection('messages').add(
                     { 'text': message,
                       'sender': signedUser.email,
                       'time' :FieldValue.serverTimestamp(),
                     }
                 );

               },
                   child:  const Text('send ', style: TextStyle(
                       color: Color(0xff3f4d72)  ,
                       fontSize: 18,
                       fontWeight: FontWeight.bold
                   ),),)
             ],
           ),
            )


          ],
        ),
      ),

    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    super.key,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {

        List<MessageDecoration>messages =[];
        if(!snapshot.hasData)
          {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
          }
        final messagesOfApp = snapshot.data!.docs.reversed;
        for( var message in messagesOfApp )
          {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser = signedUser.email;

            final messageAppear =MessageDecoration(
              sender: '$messageSender', text: '$messageText',
              me:  currentUser == messageSender,
            );
            messages.add(messageAppear);
          }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              reverse: true,
              children: messages,
            ),
          ),
        );
      },);
  }
}
class MessageDecoration extends StatelessWidget {
  const MessageDecoration({required this.sender,required this.me,required this.text,Key? key}) : super(key: key);

  final String sender ;
  final String text;
  final bool me;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:me? CrossAxisAlignment.end :  CrossAxisAlignment.start,
        children: [
          Text(sender, style: const TextStyle(
            fontSize: 13,
            color: Colors.black45
          ),),
          Material(
            elevation: 5,
            borderRadius: me? const BorderRadius.only(
                topLeft: Radius.circular(25), bottomLeft:  Radius.circular(25), bottomRight:  Radius.circular(25))
            : const BorderRadius.only(topRight:Radius.circular(25) , bottomRight: Radius.circular(25) , bottomLeft: Radius.circular(25)),
            color:  me? const Color(0xff3f4d72) :  const Color(0xff74b4fd)  ,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text('$text  ', style:
              const TextStyle(
                  fontSize: 15,
                color: Colors.white,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
