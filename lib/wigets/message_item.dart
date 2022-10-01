import 'package:firebase_batch05/auth/auth_service.dart';
import 'package:firebase_batch05/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final MessageModel messageModel;
  const MessageItem({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: messageModel.userUid == AuthService.user!.uid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(messageModel.userName ?? messageModel.email),
          ),
          // subtitle: Text(getFormatedDate(messageModel.timestamp.toDate())),
          Chip(label: Text(messageModel.msg))
        ],
      ),
    );
  }
}
