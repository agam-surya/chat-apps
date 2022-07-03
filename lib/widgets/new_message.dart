import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  TextEditingController _mesController = TextEditingController();

  void _sendMessage() {
    if (_message == '') {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chats').add({
      'text': _message,
      'createdAt': Timestamp.now(),
      'userId': user!.uid,
    });
    _mesController.clear();
    _message = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _mesController,
            onChanged: (value) {
              setState(() {
                _message = value;
              });
            },
          )),
          IconButton(
              onPressed: () {
                _sendMessage();
              },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
