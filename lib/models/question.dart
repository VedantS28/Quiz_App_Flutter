import 'package:quiz_app/models/option.dart';

class Question {
  final int id;
  final String description;
  final String topic;
  final List<Option> options;
  final String detailedSolution;

  Question({
    required this.id,
    required this.description,
    required this.topic,
    required this.options,
    required this.detailedSolution,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      description: json['description'],
      topic: json['topic'],
      detailedSolution: json['detailed_solution'],
      options: (json['options'] as List)
          .map((o) => Option.fromJson(o))
          .toList(),
    );
  }
}

