import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String username;
  final String? photoURL;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final bool isPrivate;
  final bool isVerified;
  final bool isPremium;
  final DateTime createdAt;
  final Map<String, dynamic> notificationSettings;

  const UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.username,
    this.photoURL,
    this.bio,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.isPrivate = false,
    this.isVerified = false,
    this.isPremium = false,
    required this.createdAt,
    this.notificationSettings = const {},
  });

  factory UserModel.fromFirestore(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      username: data['username'] ?? '',
      photoURL: data['photoURL'],
      bio: data['bio'],
      followersCount: data['followersCount'] ?? 0,
      followingCount: data['followingCount'] ?? 0,
      postsCount: data['postsCount'] ?? 0,
      isPrivate: data['isPrivate'] ?? false,
      isVerified: data['isVerified'] ?? false,
      isPremium: data['isPremium'] ?? false,
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
      notificationSettings: data['notificationSettings'] ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'username': username,
      'photoURL': photoURL,
      'bio': bio,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postsCount': postsCount,
      'isPrivate': isPrivate,
      'isVerified': isVerified,
      'isPremium': isPremium,
      'createdAt': createdAt,
      'notificationSettings': notificationSettings,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? username,
    String? photoURL,
    String? bio,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    bool? isPrivate,
    bool? isVerified,
    bool? isPremium,
    DateTime? createdAt,
    Map<String, dynamic>? notificationSettings,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      photoURL: photoURL ?? this.photoURL,
      bio: bio ?? this.bio,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      isPrivate: isPrivate ?? this.isPrivate,
      isVerified: isVerified ?? this.isVerified,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      notificationSettings: notificationSettings ?? this.notificationSettings,
    );
  }

  @override
  List<Object?> get props => [id, email, displayName, username, photoURL, bio, followersCount, followingCount, postsCount, isPrivate, isVerified, isPremium];
}
