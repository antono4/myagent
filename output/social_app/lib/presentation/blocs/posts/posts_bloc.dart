import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/post_model.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostsEvent {}

class CreatePost extends PostsEvent {
  final String content;
  final List<String> mediaUrls;
  final MediaType mediaType;
  
  CreatePost({required this.content, this.mediaUrls = const [], this.mediaType = MediaType.text});
  
  @override
  List<Object?> get props => [content, mediaUrls, mediaType];
}

class LikePost extends PostsEvent {
  final String postId;
  final String userId;
  
  LikePost({required this.postId, required this.userId});
  
  @override
  List<Object?> get props => [postId, userId];
}

class CommentOnPost extends PostsEvent {
  final String postId;
  final String comment;
  final String authorName;
  
  CommentOnPost({required this.postId, required this.comment, required this.authorName});
  
  @override
  List<Object?> get props => [postId, comment, authorName];
}

abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<PostModel> posts;
  
  PostsLoaded(this.posts);
  
  @override
  List<Object?> get props => [posts];
}

class PostsError extends PostsState {
  final String message;
  
  PostsError(this.message);
  
  @override
  List<Object?> get props => [message];
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<CreatePost>(_onCreatePost);
    on<LikePost>(_onLikePost);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    try {
      // Load posts from Firestore
      // This is a placeholder - implement with FirebaseService
      emit(PostsLoaded([]));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostsState> emit) async {
    // Create post implementation
  }

  Future<void> _onLikePost(LikePost event, Emitter<PostsState> emit) async {
    // Like post implementation
  }
}
