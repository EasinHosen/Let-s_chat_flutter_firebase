import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_batch05/models/message_model.dart';
import 'package:firebase_batch05/models/user_model.dart';

class DBHelper {
  static const String collectionUser = 'users';
  static const String collectionRoomMsg = 'ChatRoomMessages';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(collectionUser).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Future<void> addMsg(MessageModel messageModel) {
    return _db.collection(collectionRoomMsg).doc().set(messageModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRoomMessages() =>
      _db
          .collection(collectionRoomMsg)
          .orderBy('msgId', descending: true)
          .snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(
          String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserByUidFuture(
          String uid) =>
      _db.collection(collectionUser).doc(uid).get();

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUser).doc(uid).update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      _db.collection(collectionUser).snapshots();

  // updateAvailable(String uid, Map<String, dynamic> map) {
  //   _db.collection(collectionUser).doc(uid).update(map);
  // }
}
