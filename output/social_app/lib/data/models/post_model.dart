import 'package:equatable/equatable.dart';

enum MediaType { text, image, video }

class PostModel extends Equatable {
  final String id;
  final String authorId;
  final String authorName;
  final String? authorPhotoURL;
  final String content;
  final List<String> mediaUrls;
  final MediaType mediaType;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final List<String> likedByUsers;
  final bool isEdited;
  final String? location;
  final DateTime createdAt;

  const PostModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorPhotoURL,
    required this.content,
    this.mediaUrls = const [],
    this.mediaType = MediaType.text,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.likedByUsers = const [],
    this.isEdited = false,
    this.location,
    required this.createdAt,
  });

  factory PostModel.fromFirestore(String id, Map<String, dynamic> data) {
    return PostModel(
      id: id,
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      authorPhotoURL: data['authorPhotoURL'],
      content: data['content'] ?? '',
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      mediaType: MediaType.values.firstWhere(
        (e) => e.name == data['mediaType'],
        orElse: () => MediaType.text,
      ),
      likesCount: data['likesCount'] ?? 0,
      commentsCount: data['commentsCount'] ?? 0,
      sharesCount: data['sharesCount'] ?? 0,
      likedByUsers: List<String>.from(data['likedByUsers'] ?? []),
      isEdited: data['isEdited'] ?? false,
      location: data['location'],
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'authorPhotoURL': authorPhotoURL,
      'content': content,
      'mediaUrls': mediaUrls,
      'mediaType': mediaType.name,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'sharesCount': sharesCount,
      'likedByUsers': likedByUsers,
      'isEdited': isEdited,
      'location': location,
      'createdAt': createdAt,
    };
  }

  PostModel copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? authorPhotoURL,
    String? content,
    List<String>? mediaUrls,
    MediaType? mediaType,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    List<String>? likedByUsers,
    bool? isEdited,
    String? location,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorPhotoURL: authorPhotoURL ?? this.authorPhotoURL,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      mediaType: mediaType ?? this.mediaType,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      likedByUsers: likedByUsers ?? this.likedByUsers,
      isEdited: isEdited ?? this.isEdited,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, authorId, content, mediaUrls, mediaType, likesCount, commentsCount, sharesCount, likedByUsers, createdAt];
}
