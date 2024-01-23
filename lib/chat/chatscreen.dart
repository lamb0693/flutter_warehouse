import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage({super.key});

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try{
      final user =_auth.currentUser;
      if(user != null) {
        if (kDebugMode) {
          print(user.email);
        }
      }
    } catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Chat Screen'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              // Navigator.pop(context);
            },
            icon: const Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/HzeZX87RbuRpb9PknI4z/message').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index){
              return Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(docs[index]['text'],
                  style: const TextStyle(
                    fontSize: 20.0
                  ),
                ),
              );
            }
          );
        },
      )
    );
  }
}
