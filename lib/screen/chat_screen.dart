import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  // butuh destination = uid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     FirebaseFirestore.instance
        //         .collection('chats')
        //         .add({'text': 'new chat'});
        //   },
        //   child: const Text('Add'),
        // ),
        appBar: AppBar(
          title: const Text('ChatApp'),
          actions: [
            // LogOut
            IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Messages());
  }
}
