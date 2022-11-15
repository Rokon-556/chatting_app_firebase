import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseFirestore.instance
              .collection('chats/Rxr3YZd1cBqkc3RFBW3Z/message')
              .snapshots() ,builder: (context,streamSnapShot){
                final documnets=streamSnapShot.data!.docs;
                if(streamSnapShot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
        return ListView.builder(
        itemBuilder: ((context, index) => Container(
              padding: const EdgeInsets.all(10),
              child: Text(documnets[index]['text']),
            )),
        itemCount:documnets.length,
      );
      })  ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/Rxr3YZd1cBqkc3RFBW3Z/message').add({'text': 'Float Button Data'});
            },
        child: const Icon(Icons.add),
      ),
    );
  }
}
