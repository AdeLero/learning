import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/Medwiz/models/chat_message_model.dart';
import 'package:my_learning/Medwiz/repos/chat_repos.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(
          ChatSuccessState(
            messages: [],
          ),
        ) {
    on<GenerateNewChatMessageEvent>(generateNewChatMessageEvent);
  }
  List<ChatMessage> messages = [];

  FutureOr<void> generateNewChatMessageEvent(
      GenerateNewChatMessageEvent event, Emitter<ChatState> emit) async {
    log("Event received: ${event.inputMessage}");
    messages.add(
      ChatMessage(
        role: "user",
        parts: [
          ChatPart.text(event.inputMessage),
        ],
      ),
    );
    emit(
      ChatSuccessState(messages: messages),
    );
    log("Sending API request with messages: ${messages.map((m) => m.toJson()).toList()}");
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if (generatedText.isNotEmpty) {
      messages.add(
        ChatMessage(
          role: "model",
          parts: [
            ChatPart.text(generatedText),
          ],
        ),
      );
      emit(
        ChatSuccessState(messages: messages),
      );
    }
  }}
