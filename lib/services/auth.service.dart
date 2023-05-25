import 'package:firebase_auth/firebase_auth.dart';
import 'package:leo/models/auth.model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Stream<User?> get ideTokenChanges => _firebaseAuth.idTokenChanges();

  AuthModel? _userFromFirebaseUser(User? user) {
    return user != null ? AuthModel(user.uid) : null;
  }

  Future<AuthModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = response.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
