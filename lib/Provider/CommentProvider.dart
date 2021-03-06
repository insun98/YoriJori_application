import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../src/comments.dart';

class CommentProvider extends ChangeNotifier {

  CommentProvider(String docId) {
    init(docId);
  }

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<Com> _guestBookMessages = [];

  List<Com> get guestBookMessages => _guestBookMessages;

  Future<DocumentReference> addMessageToGuestBook(String message,
      String docId, String image_url ) async {
    return FirebaseFirestore.instance
        .collection('post')
        .doc(docId)
        .collection('comment')
        .add(<String, dynamic>{
      'text': message,
      'timestamp':  DateTime.now(),
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'image_url':
      image_url,
    });
  }

  Future<void> init(String docId) async {
    if(docId != ""){
    FirebaseAuth.instance.userChanges().listen((user) {
      _guestBookSubscription = FirebaseFirestore.instance
          .collection('post').doc(docId)
          .collection('comment')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        _guestBookMessages = [];
        if(snapshot.docs.isNotEmpty) {
          for (final document in snapshot.docs) {
            _guestBookMessages.add(
              Com(
                name: document.data()['name'] as String,
                message: document.data()['text'] as String,
                formattedDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                    .format(document.data()['timestamp'].toDate()),
                image_url: document.data()['image_url'],
                uid: document.data()['userId'] as String,
              ),
            );
          }

          notifyListeners();
        }
      });

    });
  }}

  }
class Com {
  Com(
      {required this.name, required this.message, required this.formattedDate, required this.image_url, required this.uid});
  final String name;
  final String message;
  final String formattedDate;
  final String image_url;
  final String uid;
}
