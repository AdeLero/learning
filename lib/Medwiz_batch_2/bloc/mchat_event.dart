part of 'mchat_bloc.dart';

@immutable
sealed class MchatEvent {}

class SendNewMessage extends MchatEvent {
  final String messageInput;
  final File? messageFile;

  SendNewMessage({
    required this.messageInput,
    this.messageFile,
  });
}

class LoadMessages extends MchatEvent {}
