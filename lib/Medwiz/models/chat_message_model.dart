class ChatMessage {
  final String role;
  final List<ChatPart> parts;

  ChatMessage({required this.role, required this.parts});

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    role: json["role"],
    parts: List<ChatPart>.from(json["parts"].map((x) => ChatPart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
  };
}

class ChatPart {
  final String text;

  ChatPart({required this.text});

  factory ChatPart.fromJson(Map<String, dynamic> json) => ChatPart(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}
