part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}


class GenerateNewChatMessageEvent extends ChatEvent {
  final String inputMessage;
  final String? filePath;
  GenerateNewChatMessageEvent({required this.inputMessage, this.filePath});
}

class PickFile extends ChatEvent {
  final String? text;
  final String? filePath;

  PickFile({this.text, this.filePath});
}