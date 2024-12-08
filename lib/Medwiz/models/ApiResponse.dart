class ApiResponse{
  final List<Candidate> candidates;

  ApiResponse({required this.candidates});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    candidates: (json["candidates"] as List).map((m) => Candidate.fromJson(m)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "candidates": candidates.map((m) => m.toJson()).toList(),
  };
}

class Candidate{
  final Content content;
  final String? role;

  Candidate({required this.content, required this.role});

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
    content: Content.fromJson(json["content"]),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "content": content.toJson(),
  };
}

class Content {
  final List<Part> parts;

  Content({required this.parts});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
      parts: (json["parts"] as List).map((e) => Part.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "parts":parts.map((e) => e.toJson()).toList(),
  };
}

class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) =>
    Part(
      text: json["text"],
    );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}