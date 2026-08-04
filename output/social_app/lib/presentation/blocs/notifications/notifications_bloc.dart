import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String type;
  final String title;
  final String body;
  final String? fromUserId;
  final String? referenceId;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.fromUserId,
    this.referenceId,
    this.isRead = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, title, body, fromUserId, referenceId, isRead, createdAt];
}

abstract class NotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationsEvent {}

class MarkNotificationRead extends NotificationsEvent {
  final String notificationId;
  MarkNotificationRead(this.notificationId);
  @override
  List<Object?> get props => [notificationId];
}

class MarkAllNotificationsRead extends NotificationsEvent {}

abstract class NotificationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsLoaded(this.notifications);
  @override
  List<Object?> get props => [notifications];
}

class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
  @override
  List<Object?> get props => [message];
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<MarkNotificationRead>(_onMarkRead);
    on<MarkAllNotificationsRead>(_onMarkAllRead);
  }

  Future<void> _onLoadNotifications(LoadNotifications event, Emitter<NotificationsState> emit) async {
    emit(NotificationsLoading());
    // Load from Firestore
  }

  Future<void> _onMarkRead(MarkNotificationRead event, Emitter<NotificationsState> emit) async {
    // Mark as read in Firestore
  }

  Future<void> _onMarkAllRead(MarkAllNotificationsRead event, Emitter<NotificationsState> emit) async {
    // Mark all as read
  }
}
