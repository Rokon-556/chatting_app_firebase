import 'package:chatting_app/screens/auth_screen.dart';
import 'package:chatting_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


 
  Future<void> _onBackgroundMessage(RemoteMessage msg) async {
 // await Firebase.initializeApp();
 
  print("onBackgroundMessage: ${msg}");
  print("onBackgroundMessage.data: ${msg.data}");
  print("onBackgroundMessage.notification.title: ${msg.notification?.title}");
  print("onBackgroundMessage.notification.body: ${msg.notification?.body}");
}

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getToken().then((token) => print("token: $token"));
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.pink,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.deepPurple),
      ),
      home: StreamBuilder(builder:(context,userSnapShot){
        if(userSnapShot.hasData){
          return const ChatScreen();
        }else{
          return const AuthScreen();
        }
      },stream: FirebaseAuth.instance.idTokenChanges(), ),
    );
  }
}
