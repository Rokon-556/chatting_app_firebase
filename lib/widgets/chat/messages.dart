import 'package:chatting_app/widgets/chat/mesaage_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});
  
// final picker = ImagePicker();
// final pickedImage = await picker.getImage(...);
// final pickedImageFile = File(pickedImage.path); 

  @override
  Widget build(BuildContext context) {
    return   FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt',descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
 
            final snapshotData = snapshot.data?.docs;
            return ListView.builder(
              reverse: true,
              itemCount: snapshotData!.length,
              itemBuilder: (context, index) => MessageBubble(
                message:snapshotData[index]['text'],
                isMe:snapshotData[index]['userId'] == futureSnapshot.data?.uid,
                    // ? true
                    // : false,
                userName: snapshotData[index]['username'], 
                imageUrl: snapshotData[index]['userImage'],   
                key: ValueKey(snapshotData[index].id), // late need to add
              ),
            );
          },
        );
      },
    );
  }
}
