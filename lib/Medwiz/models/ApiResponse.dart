import 'package:my_learning/Medwiz/models/chat_message_model.dart';

extension ChatCandidateExtension on ChatCandidates{
  String get response => (chatMessage.parts.lastOrNull as TextChatPart).text;
}