import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:mime/mime.dart';
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
    on<PickFile>(pickFile);
  }
  List<ChatMessage> messages = [];



  // Future<http.MultipartFile> prepareFile(String filePath) async {
  //   final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';
  //   final file = File(filePath);
  //
  //   if (!file.existsSync()) {
  //     throw Exception("File not found at path: $filePath");
  //   }
  //
  //   return await http.MultipartFile.fromPath(
  //     'file', // Field name expected by the server
  //     filePath,
  //     contentType: MediaType.parse(mimeType),
  //   );
  // }

  FutureOr<void> generateNewChatMessageEvent(
      GenerateNewChatMessageEvent event, Emitter<ChatState> emit) async {
    log("Event received: ${event.inputMessage}");

    FilePart? filePart;

    if (event.filePath != null) {
      final filePath = event.filePath!;
      log("Uploading file: $filePath");

      final fileUri = await ChatRepo.uploadFile(
        File(filePath),
        "Uploaded File",
      );

      if (fileUri != null) {
        log("file successfully uploaded: $fileUri");

        final mimeType = lookupMimeType(filePath);
        filePart = FilePart(
            fileType: mimeType,
            fileLocation: fileUri,
          );
        }
      }
    messages.add(
      ChatMessage(
        role: "user",
        parts: [
          if (filePart != null) ChatPart.file(filePart),
          ChatPart.text(event.inputMessage),
        ],
      ),
    );
    emit(ChatSuccessState(messages: messages));
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
  }

  void pickFile(PickFile event, Emitter<ChatState> emit) {
    if (event.filePath != null) {
      emit(ChatTypingState(
          text: event.text, filePath: event.filePath, messages: messages));
    }
  }
}
