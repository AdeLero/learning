import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/Medwiz_batch_2/models/message_model.dart';

part 'mchat_event.dart';
part 'mchat_state.dart';

class MchatBloc extends Bloc<MchatEvent, MchatState> {
  MchatBloc() : super(MchatSuccessState(messages: [])) {
    on<SendNewMessage>(sendNewMessage);
  }

  final List<MessageModel> messages = [];
  final Gemini gemini = Gemini.instance;

  FutureOr<void> sendNewMessage(
      SendNewMessage event, Emitter<MchatState> emit) async {
    messages.add(MessageModel(role: "User", text: event.messageInput));
    emit(MchatSuccessState(messages: messages));

    try {
      final chatContent = messages.map((msg) {
        return Content(
          role: msg.role.toLowerCase(),
          parts: [Part.text(msg.text)],
        );
      }).toList();
      final String finalAiResponse = await gemini.streamChat(
        chatContent,
      ).fold("", (previous, message) {
        final aiResponsePart = message.output ?? "";
        return previous += aiResponsePart;
      });
      
      if (messages.isNotEmpty && messages.last.role == "Model") {
        messages[messages.length -1] = MessageModel(role: "Model", text: finalAiResponse);
      } else {
        messages.add(MessageModel(role: "Model", text: finalAiResponse));
      }
      emit(MchatSuccessState(messages: messages));
    } catch (e) {
      log(e.toString());
    }
  }
}
