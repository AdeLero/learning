part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatSuccessState extends ChatState{
  final List<ChatMessage> messages;

  ChatSuccessState({required this.messages});
}

class ChatTypingState extends ChatState {
  final String? text;
  final String? filePath;
  final List<ChatMessage>? messages;

  ChatTypingState({this.text, this.filePath, this.messages});
}
