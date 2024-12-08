part of 'mchat_bloc.dart';

@immutable
sealed class MchatEvent {}

class SendNewMessage extends MchatEvent {
  final String messageInput;

  SendNewMessage({required this.messageInput});
}

class LoadMessages extends MchatEvent {}
