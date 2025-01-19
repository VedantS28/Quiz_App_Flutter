import 'package:quiz_app/models/question.dart';

class Quiz {
  final int id;
  final String title;
  final String topic;
  final int duration;
  final double negativeMarks;
  final double correctAnswerMarks;
  final bool shuffle;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.topic,
    required this.duration,
    required this.negativeMarks,
    required this.correctAnswerMarks,
    required this.shuffle,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      topic: json['topic'],
      duration: json['duration'],
      negativeMarks: double.parse(json['negative_marks']),
      correctAnswerMarks: double.parse(json['correct_answer_marks']),
      shuffle: json['shuffle'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

