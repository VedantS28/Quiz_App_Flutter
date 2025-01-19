class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'],
      isCorrect: json['is_correct'],
    );
  }
}