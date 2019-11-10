import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class UsersRepository {

  final String _userCollection = "users";
  final String _userIdentifier = "username";

  CollectionReference _getCollection() {
    return Firestore
        .instance
        .collection(_userCollection);
  }

  Future<DocumentSnapshot> _fetchDocument(User user) async {
    var query = await _getCollection().where(_userIdentifier, isEqualTo: user.username)
        .getDocuments();
    return query.documents.length > 0 ? query.documents.first : null;
  }

  Future<User> _fetchExisting(User user) async {
    var document = await _fetchDocument(user);
    if(document == null)
      return null;
    return User.fromJson(document.data);
  }

  Future<User> addOrUpdate(User user) async {
    var existingUser = await _fetchExisting(user);
    if(existingUser != null) {
      return existingUser;
    }

    await _getCollection().add(user.toJson());

    return user;
  }
}