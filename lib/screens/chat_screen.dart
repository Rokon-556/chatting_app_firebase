import 'package:chatting_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chat/messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

void _initNotifications() async {
    final notifications = FirebaseMessaging.instance;
    final settings = await notifications.requestPermission();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }
 
    FirebaseMessaging.onMessage.listen((msg) {
      print("onMessage: $msg");
    });
 
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print("onMessageOpenedApp: $msg");
    });
  }
 
  @override
  void initState() {
    super.initState();
 
    _initNotifications();
  }


// @override
//   void initState() {
//     // final fbm=FirebaseMessaging.instance;
//     // fbm.requestPermission();
//     // fbm.
//     // super.initState();
//     FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//       _firebaseMessaging
//         .getToken()
//         .then((String? token) {
//       assert(token != null);
//     });
//     FirebaseMessaging.onMessage.listen(
//       (RemoteMessage message) {
//         print('Got a message whilst in the foreground!');
//         print(message.notification!.body);
//         return;
//       },
//     );
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatting App'),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(Icons.exit_to_app,color: Colors.black,),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
