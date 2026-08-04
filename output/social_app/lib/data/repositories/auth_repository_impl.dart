import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class AuthRepositoryImpl {
  final FirebaseService _firebaseService;
  
  AuthRepositoryImpl({FirebaseService? firebaseService}) 
      : _firebaseService = firebaseService ?? FirebaseService();

  // Get current user
  User? get currentUser => _firebaseService.currentUser;
  
  // Get current user ID
  String? get currentUserId => currentUser?.uid;

  // Sign up with email and password
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    required String username,
  }) async {
    final credential = await _firebaseService.auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    final user = credential.user!;
    
    // Create user document
    final userModel = UserModel(
      id: user.uid,
      email: email,
      displayName: displayName,
      username: username,
      createdAt: DateTime.now(),
    );
    
    await _firebaseService.userDoc(user.uid).set(userModel.toFirestore());
    
    return userModel;
  }

  // Sign in with email and password
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseService.auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    final user = credential.user!;
    final doc = await _firebaseService.userDoc(user.uid).get();
    
    return UserModel.fromFirestore(user.uid, doc.data() ?? {});
  }

  // Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    // Google Sign In implementation
    // ... (requires GoogleSignIn plugin)
    throw UnimplementedError();
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseService.auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _firebaseService.auth.sendPasswordResetEmail(email: email);
  }

  // Get user by ID
  Future<UserModel?> getUserById(String userId) async {
    final doc = await _firebaseService.userDoc(userId).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(userId, doc.data()!);
  }

  // Update user profile
  Future<void> updateProfile({
    required String userId,
    String? displayName,
    String? bio,
    String? photoURL,
  }) async {
    final updates = <String, dynamic>{};
    if (displayName != null) updates['displayName'] = displayName;
    if (bio != null) updates['bio'] = bio;
    if (photoURL != null) updates['photoURL'] = photoURL;
    
    await _firebaseService.userDoc(userId).update(updates);
  }

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _firebaseService.auth.authStateChanges();
}
