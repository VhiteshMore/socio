import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:socio/model/user/user.dart';

import 'onboarding_repo.dart';

class OnBoardingRepoImpl extends OnBoardingRepo {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<User?> loginUser({required String email, required String password}) async {
    try {
      User? userData;
      final response  = await _auth.signInWithEmailAndPassword(email: email, password: password);
      userData = response.user;
      return userData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> createUser({required String email, required String password}) async{
    try {
      User? userData;
      final response  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      userData = response.user;
      return userData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> getUser({required String uid}) async {
    try {
      QueryDocumentSnapshot<Map<String, dynamic>>? queryDocumentSnapshot;
      final response = await _fireStore.collection('users').get();
      if (response.docs.isNotEmpty) {
        for (var e in response.docs) {
          debugPrint("${e.id}, ${e.reference}, ${e.data()}");
          if (e.id == uid) {
            queryDocumentSnapshot = e;
            UserAccount.fromJson(e.data());
            break;
          }
        }
      }
      return queryDocumentSnapshot;
    } catch (e) {
      rethrow;
    }
  }



}