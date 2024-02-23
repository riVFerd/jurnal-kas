import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretest/domain/repositories/user_repository.dart';

import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user in 'user' collection
      final user = UserModel(
        id: credential.user!.uid,
        email: email,
        username: email.split('@').first,
      );
      FirebaseFirestore.instance.collection('users').doc(user.id).set(user.toJson());

      return user;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(user) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(
            credential.user!.uid,
          )
          .get();

      return UserModel.fromJson(user.data()!);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> authCheck() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));
    }
    return Future.value(null);
  }

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
