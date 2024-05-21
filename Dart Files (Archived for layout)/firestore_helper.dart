import 'package:cloud_firestore/cloud_firestore.dart';
import 'perfume.dart';
import 'user.dart';

class FirestoreHelper {
  static final FirestoreHelper _instance =
      FirestoreHelper._privateConstructor();

  static FirestoreHelper get instance => _instance;

  FirestoreHelper._privateConstructor();

  final CollectionReference perfumeCollection =
      FirebaseFirestore.instance.collection('Perfumes');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  // Insert a new user
  Future<void> insertUser(User user) async {
    await userCollection.add(user.toMap());
  }

  // Query all users
  Future<List<User>> queryAllUsers() async {
    QuerySnapshot snapshot = await userCollection.get();
    return snapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Update a user
  Future<void> updateUser(String id, User user) async {
    await userCollection.doc(id).update(user.toMap());
  }

  // Delete a user
  Future<void> deleteUser(String id) async {
    await userCollection.doc(id).delete();
  }

  // Insert a new perfume
  Future<void> insertPerfume(Perfume perfume) async {
    await perfumeCollection.add(perfume.toMap());
  }

  // Query all perfumes
  Future<List<Perfume>> queryAllPerfumes() async {
    QuerySnapshot snapshot = await perfumeCollection.get();
    return snapshot.docs
        .map((doc) => Perfume.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Update a perfume
  Future<void> updatePerfume(String id, Perfume perfume) async {
    await perfumeCollection.doc(id).update(perfume.toMap());
  }

  // Delete a perfume
  Future<void> deletePerfume(String id) async {
    await perfumeCollection.doc(id).delete();
  }
}
