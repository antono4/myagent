import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Auth
  FirebaseAuth get auth => _auth;
  User? get currentUser => _auth.currentUser;
  
  // Firestore
  FirebaseFirestore get firestore => _firestore;
  
  // Storage
  FirebaseStorage get storage => _storage;

  // Messaging
  FirebaseMessaging get messaging => _messaging;

  // Users Collection
  CollectionReference get usersRef => _firestore.collection('users');
  
  // Posts Collection
  CollectionReference get postsRef => _firestore.collection('posts');
  
  // Stories Collection
  CollectionReference get storiesRef => _firestore.collection('stories');
  
  // Messages Collection
  CollectionReference get conversationsRef => _firestore.collection('conversations');
  
  // Groups Collection
  CollectionReference get groupsRef => _firestore.collection('groups');
  
  // Notifications Collection
  CollectionReference notificationsRef(String userId) => 
      _firestore.collection('notifications').doc(userId).collection('items');

  // Live Streams Collection
  CollectionReference get liveStreamsRef => _firestore.collection('liveStreams');

  // Follows Collection
  CollectionReference get followsRef => _firestore.collection('follows');

  // Helper to get user document
  DocumentReference userDoc(String uid) => usersRef.doc(uid);
  
  // Helper to get post document
  DocumentReference postDoc(String postId) => postsRef.doc(postId);
  
  // Helper to get conversation document
  DocumentReference conversationDoc(String conversationId) => 
      conversationsRef.doc(conversationId);

  // Upload image to storage
  Future<String> uploadImage(String path, String fileName) async {
    final ref = _storage.ref().child(path).child(fileName);
    final uploadTask = ref.putFile(null); // Add File here
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // Send notification
  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    String? data,
  }) async {
    await notificationsRef(userId).add({
      'title': title,
      'body': body,
      'data': data,
      'createdAt': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}
