import '../entities/user.dart';

abstract class UserRepository {
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User?> authCheck();
  Future<void> signOut();
}
