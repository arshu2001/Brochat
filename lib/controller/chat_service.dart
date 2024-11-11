import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendMessage(String receiverID, String message, [String? imageUrl]) async {
    try {
      final String currentUserID = _auth.currentUser!.uid;
      final String currentUserEmail = _auth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();

      List<String> ids = [currentUserID, receiverID];
      ids.sort();
      String chatRoomID = ids.join('_');

      await _firestore
          .collection('chat')
          .doc(chatRoomID)
          .collection('messages')
          .add({
        'senderID': currentUserID,
        'senderEmail': currentUserEmail,
        'receiverID': receiverID,
        'message': message,
        'imageUrl': imageUrl,
        'timestamp': timestamp,
        'isRead': false,
      });
    } catch (e) {
      print('Error sending message: $e');
      throw e;
    }
  }

  Stream<Map<String, dynamic>?> getLatestMessageWithReadStatus(String otherUserID) {
    final String currentUserID = _auth.currentUser!.uid;
    List<String> ids = [currentUserID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          return snapshot.docs.first.data();
        });
  }

  Future<void> markMessagesAsRead(String otherUserID) async {
    final String currentUserID = _auth.currentUser!.uid;
    List<String> ids = [currentUserID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    var messages = await _firestore
        .collection('chat')
        .doc(chatRoomID)
        .collection('messages')
        .where('receiverID', isEqualTo: currentUserID)
        .where('isRead', isEqualTo: false)
        .get();

    WriteBatch batch = _firestore.batch();
    for (var doc in messages.docs) {
      batch.update(doc.reference,{'isRead': true});
    }
    await batch.commit();
  }

  Stream<int> getUnreadMessageCount(String otherUserID) {
    final String currentUserID = _auth.currentUser!.uid;
    List<String> ids = [currentUserID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat')
        .doc(chatRoomID)
        .collection('messages')
        .where('receiverID', isEqualTo: currentUserID)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }


  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}