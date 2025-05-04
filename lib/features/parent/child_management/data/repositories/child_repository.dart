import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voca_grow_app/features/auth/data/models/user_model.dart';
import '../models/child_model.dart';

class ChildRepository {
  final FirebaseFirestore _firestore;
  final UserModel userParent;

  ChildRepository({required this.userParent, FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _childrenCollection {
    return _firestore.collection('users');
  }

  Future<void> addChild(ChildModel child) async {
    try {
      await _childrenCollection.doc(child.id).set(child.toJson());
    } catch (e) {
      throw Exception('Failed to add child: $e');
    }
  }

  Future<void> updateChild(ChildModel child) async {
    try {
      await _childrenCollection.doc(child.id).update(child.toJson());
    } catch (e) {
      throw Exception('Failed to update child: $e');
    }
  }

  Future<void> deleteChild(String childId) async {
    try {
      await _childrenCollection.doc(childId).delete();
    } catch (e) {
      throw Exception('Failed to delete child: $e');
    }
  }

  Future<List<ChildModel>> fetchChildren() async {
    try {
      final querySnapshot =
          await _childrenCollection
              .where('parentEmail', isEqualTo: userParent.email)
              .get();

      return querySnapshot.docs
          .map((doc) => ChildModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch children: $e');
    }
  }
}
