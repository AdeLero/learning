class ApiResponse {
  final List<ChatCandidates> candidates;

  ApiResponse({required this.candidates});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      candidates: (json["candidates"] as List).map((e) => ChatCandidates.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> json) {
    return {
      "candidates": candidates.map((x) => x.toJson()).toList(),
    };
  }
}

class ChatCandidates {
  final ChatMessage chatMessage;
  final String finishReason;
  final int index;
  final List<SafetyRatings> safetyRatings;

  ChatCandidates({
    required this.chatMessage,
    required this.finishReason,
    required this.index,
    required this.safetyRatings,
  });

  factory ChatCandidates.fromJson(Map<String, dynamic> json) {
    return ChatCandidates(
        chatMessage:
            ChatMessage.fromJson(json["content"] as Map<String, dynamic>),
        finishReason: json["finishReason"] as String,
        index: (json["index"] as num).toInt(),
        safetyRatings: (json["safetyRatings"] as List<dynamic>)
            .map((e) => SafetyRatings.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        "content": chatMessage.toJson(),
        "finishReason": finishReason,
        "index": index,
        "safetyRatings": safetyRatings.map((e) => e.toJson()).toList(),
      };

  static List<ChatCandidates> jsonToList(List list) => list
      .map((e) => ChatCandidates.fromJson(e as Map<String, dynamic>))
      .toList();
}

class SafetyRatings {
  String? category;
  String? probability;

  SafetyRatings({
    this.category,
    this.probability,
  });

  factory SafetyRatings.fromJson(Map<String, dynamic> json) => SafetyRatings(
        category: json['category'] as String?,
        probability: json['probability'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'category': category,
        'probability': probability,
      };
}

class ChatMessage {
  final String role;
  final List<ChatPart> parts;

  ChatMessage({required this.role, required this.parts});

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        role: json["role"] as String,
        parts: (json["parts"] as List)
            .map((x) => ChatPart.fromJson(x as Map<String, dynamic>))
            .toList(),
      );

  static List<ChatMessage> jsonToList(List list) =>
      list.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        "role": role,
        "parts": parts.map((x) => ChatPart.toJson(x)).toList(),
      };
}

abstract interface class ChatPart {
  factory ChatPart.text(String text) => TextChatPart(text);

  factory ChatPart.fromJson(Map<String, dynamic> json) {
    return ChatPart.text(json["text"] as String);
  }

  static List<ChatPart> jsonToList(List list) =>
      list.map((e) => ChatPart.fromJson(e as Map<String, dynamic>)).toList();

  static Map<String, dynamic> toJson(ChatPart e) {
    if (e is TextChatPart) {
      return e.toJson();
    }
    throw UnsupportedError("${e.runtimeType} not supported!");
  }
}

class TextChatPart implements ChatPart {
  String text;
  TextChatPart(this.text);

  static List<ChatPart> jsonToList(List list) =>
      list.map((e) => ChatPart.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
