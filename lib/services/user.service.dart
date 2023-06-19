import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leo/models/user.model.dart';

class UserService {
  final String uid;
  UserService({required this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  //get user from document
  UserModel _userFromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: uid,
      name: (doc.data() as dynamic)['name'] ?? '',
      email: (doc.data() as dynamic)['email'] ?? '',
      role: (doc.data() as dynamic)['role'] ?? '',
      homeClub: (doc.data() as dynamic)['homeClub'] ?? '',
      region: (doc.data() as dynamic)['region'] ?? '',
      department: (doc.data() as dynamic)['department'] ?? '',
      designation: (doc.data() as dynamic)['designation'] ?? '',
    );
  }

  //get user data stream from firestore
  Stream<UserModel> get user {
    return _userCollection.doc(uid).snapshots().map(_userFromDocument);
  }

  //get user data from firestore
  Future<UserModel> getUserData() async {
    DocumentSnapshot doc = await _userCollection.doc(uid).get();
    return _userFromDocument(doc);
  }
}
