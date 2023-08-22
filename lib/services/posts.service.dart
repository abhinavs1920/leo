import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leo/models/posts.model.dart';

class PostService {
  final String? uid;
  PostService({this.uid});

  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  //add event
  Future<DocumentReference> addPost(
    String postTitle,
    String postDescription,
    List<String> images,
  ) async {
    return await _postsCollection.add(
      {
        'postTitle': postTitle,
        'postDescription': postDescription,
        'images': images,
        'createdBy': uid,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );
  }

  PostsModel _postFromDocument(DocumentSnapshot doc) {
    print(doc.data());
    return PostsModel(
      postTitle: (doc.data() as dynamic)['postTitle'] ?? '',
      postDescription: (doc.data() as dynamic)['postDescription'] ?? '',
      images: (doc.data() as dynamic)['images'] ?? [],
    );
  }

  //get all posts
  Stream<List<PostsModel>> get getAllPosts {
    return _postsCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs.map(_postFromDocument).toList(),
        );
  }

  Future<List<PostsModel>> getAllUserRoleFilteredPosts() async {
    // final user = await UserService(uid: uid).getUserData();
    //filter events data based on user role
    // if (user.role.contains('club')) {
    //   final querySnapshot = await _postsCollection
    //       .where('organizer', isEqualTo: user.homeClub)
    //       .get();
    //   return querySnapshot.docs.map(_eventFromDocument).toList();
    // } else if (user.role.contains('region')) {
    //   final querySnapshot =
    //       await _postsCollection.where('region', isEqualTo: user.region).get();
    //   return querySnapshot.docs.map(_eventFromDocument).toList();
    // } else if (user.role.contains('department')) {
    //   final querySnapshot = await _postsCollection
    //       .where('department', isEqualTo: user.department)
    //       .get();
    //   return querySnapshot.docs.map(_eventFromDocument).toList();
    // }
    final querySnapshot = await _postsCollection.get();
    return querySnapshot.docs.map(_postFromDocument).toList();
  }

  //get posts list of a user
  Stream<List<QueryDocumentSnapshot<Object?>>> get getUserPosts {
    return _postsCollection.where('createdBy', isEqualTo: uid).snapshots().map(
          (event) => event.docs,
        );
  }
}
