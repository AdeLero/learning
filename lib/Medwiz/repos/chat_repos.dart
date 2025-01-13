import 'dart:developer';
import 'dart:io';

import 'package:my_learning/Medwiz/models/ApiResponse.dart';
import 'package:my_learning/Medwiz/models/chat_message_model.dart';
import 'package:dio/dio.dart';
import 'package:my_learning/Medwiz/utils/constants.dart';

class ChatRepo {
  static Future<String> chatTextGenerationRepo(List<ChatMessage> previousMessages) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=$apiKey",
          data: {
            "contents": previousMessages.map((e) => e.toJson()).toList(),
            "generationConfig": {
              "temperature": 0.85,
              "topK": 40,
              "topP": 0.95,
              "maxOutputTokens": 819,
              "responseMimeType": "text/plain"
            }
          }
      );

      if (response.statusCode!>=200 && response.statusCode!<300) {
        log("API Response: ${response.data}");
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        String generatedText = (apiResponse.candidates.first.chatMessage.parts.firstOrNull as TextChatPart).text;
        return generatedText;
      }
      return '';
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  static Future<String?> uploadFile(File file, String displayName) async {
    try {
      Dio dio = Dio();

      const String uploadUrl = "https://generativelanguage.googleapis.com/upload/v1beta/files?key=$apiKey";

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
        "displayName": displayName,
      });

      final response = await dio.post(uploadUrl, data: formData);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log("File uploaded successfully: ${response.data}");

        return response.data["uri"] as String?;
      } else {
        log("File upload failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("File upload error: $e");
      return null;
    }
  }
}
