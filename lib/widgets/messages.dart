// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bubble_message.dart';
import 'new_message.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final chatList = snapshot.data!.docs;

                  return ListView.builder(
                      reverse: true,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        final chat = chatList[index];

                        return BubbleMessage(
                          message: chat['text'],
                          isMe: chat['userId'] ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? true
                              : false,
                          doc: chat.id,
                          date: chat['createdAt'].toDate(),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
        const NewMessage(),
      ],
    );
  }
}
