import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OnBoardingRepo {

  Future<User?> loginUser({required String email, required String password});

  Future<User?> createUser({required String email, required String password});

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> getUser({required String uid});

}