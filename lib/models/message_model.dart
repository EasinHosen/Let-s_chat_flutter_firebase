import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String? userUid, image, userName, userImage;
  String msg, email;
  int? msgId;
  Timestamp timestamp;

  MessageModel(
      {this.msgId, this.userUid, this.image, this.userName, this.userImage, required this.email,  required this.msg, required this.timestamp});

  Map<String, dynamic> toMap(){
    return {
      'msgId': msgId,
      'userUid': userUid,
      'image': image,
      'msg': msg,
      'email': email,
      'userName': userName,
      'useImage': userImage,
      'timeStamp': timestamp
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
    msgId: map['msgId'],
      userUid: map['userUid'],
      image: map['image'],
      msg: map['msg'],
      email: map['email'],
      userName: map['userName'],
      userImage: map['userImage'],
      timestamp: map['timeStamp']);
}