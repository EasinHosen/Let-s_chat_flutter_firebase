import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_batch05/auth/auth_service.dart';
import 'package:firebase_batch05/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

class ChatRoomProvider extends ChangeNotifier {
  List<MessageModel> msgList = [];

  Future<void> addMsg(String msg) {
    final messageModel = MessageModel(
        userName: AuthService.user!.displayName,
        userUid: AuthService.user!.uid,
        userImage: AuthService.user!.photoURL,
        email: AuthService.user!.email!,
        msgId: DateTime.now().microsecondsSinceEpoch,
        msg: msg,
        timestamp: Timestamp.fromDate(DateTime.now()));
    return DBHelper.addMsg(messageModel);
  }

  getAllChatRoomMessages() {
    DBHelper.getAllChatRoomMessages().listen((snapshot) {
      msgList = List.generate(snapshot.docs.length,
          (index) => MessageModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
