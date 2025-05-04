import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voca_grow_app/features/auth/data/models/models.dart';

import 'auth_exceptions.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<UserModel> get userStream {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return UserModel.empty;

      try {
        final userDoc =
            await _firestore.collection('users').doc(firebaseUser.email).get();

        if (!userDoc.exists) return UserModel.empty;

        return UserModel.fromJson(userDoc.data()!);
      } catch (e) {
        return UserModel.empty;
      }
    });
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      final userDoc = await _firestore.collection('users').doc(email).get();
      if (!userDoc.exists) {
        throw Exception('User not found.');
      }

      final user = UserModel.fromJson(userDoc.data()!);
      if (user.userType != userType) {
        throw Exception('Invalid user type.');
      }

      if (userType == UserType.child) {
        if (user.password != password) {
          throw Exception('Invalid password.');
        }

        try {
          await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } catch (e) {
          await signUp(
            name: user.name,
            email: email,
            password: password,
            userType: userType,
          );
        }
      } else {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: email,
        name: name,
        email: email,
        password: password,
        userType: userType,
      );

      await _firestore.collection('users').doc(user.id).set(user.toJson());

      return user;
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  Future<void> resetPassword({
    required String email,
    required UserType userType,
  }) async {
    try {
      final userDoc = await _firestore.collection('users').doc(email).get();

      if (!userDoc.exists) {
        throw Exception('User not found.');
      }

      final user = UserModel.fromJson(userDoc.data()!);
      if (user.userType != userType) {
        throw Exception(
          'Invalid user type. Expected: ${userType.name}, Actual: ${user.userType.name}',
        );
      }

      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ResetPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw Exception('Reset password failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw SignOutFailure();
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return UserModel.empty;

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) return UserModel.empty;

      return UserModel.fromJson(userDoc.data()!);
    } catch (e) {
      throw Exception('Fetch current user failed: ${e.toString()}');
    }
  }
}
