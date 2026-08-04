import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class MessagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadConversations extends MessagesEvent {}

class LoadMessages extends MessagesEvent {
  final String conversationId;
  LoadMessages(this.conversationId);
  @override
  List<Object?> get props => [conversationId];
}

class SendMessage extends MessagesEvent {
  final String conversationId;
  final String content;
  final String senderId;
  
  SendMessage({required this.conversationId, required this.content, required this.senderId});
  
  @override
  List<Object?> get props => [conversationId, content, senderId];
}

abstract class MessagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<dynamic> conversations;
  MessagesLoaded(this.conversations);
  @override
  List<Object?> get props => [conversations];
}

class MessagesError extends MessagesState {
  final String message;
  MessagesError(this.message);
  @override
  List<Object?> get props => [message];
}

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onLoadConversations(LoadConversations event, Emitter<MessagesState> emit) async {
    emit(MessagesLoading());
    // Load conversations from Firestore
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<MessagesState> emit) async {
    emit(MessagesLoading());
    // Load messages from Firestore
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<MessagesState> emit) async {
    // Send message implementation
  }
}
