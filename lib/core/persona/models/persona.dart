class Persona {
  Persona({required this.intro, required this.character});

  final String intro;
  final String character;

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(intro: json['intro'], character: json['character']);
  }
}