import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class BubbleMessage extends StatelessWidget {
  BubbleMessage(
      {Key? key,
      required this.message,
      required this.doc,
      required this.date,
      required this.isMe})
      : super(key: key);
  bool isMe;
  String message;
  String doc;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    final textWidth = MediaQuery.of(context).size.width * 0.4;
    String time = (date.day == DateTime.now().day)
        ? "${date.hour}:${date.minute}"
        : "${date.day}:${date.month}:${date.year}";

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              if (isMe)
                SlidableAction(
                  backgroundColor: Colors.grey,
                  icon: Icons.delete,
                  onPressed: (context) {
                    FirebaseFirestore.instance
                        .collection('chats')
                        .doc(doc)
                        .delete();
                  },
                ),
              SlidableAction(
                backgroundColor: Colors.grey,
                autoClose: false,
                icon: Icons.info_outline,
                onPressed: (context) {},
              ),
            ],
          ),
          child: Container(
            width: textWidth,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: isMe ? Colors.lightBlue : Colors.lightGreen,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
            // subtitle: Text("${chat['createdAt']}"),
          ),
        ),
      ],
    );
  }
}
