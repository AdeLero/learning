part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}


class GenerateNewChatMessageEvent extends ChatEvent {
  final String inputMessage;

  GenerateNewChatMessageEvent({required this.inputMessage});
}