import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/option.dart';
import 'dart:async';

import 'package:quiz_app/screens/result_screen.dart';

class QuizProvider extends ChangeNotifier {
  late Quiz quiz;
  int currentQuestionIndex = 0;
  Map<int, int> userAnswers = {};
  int score = 0;
  late Timer timer;
  int remainingTime = 0;

  void initQuiz(BuildContext context, Quiz newQuiz) {
    quiz = newQuiz;
    remainingTime = quiz.duration * 60;
    startTimer(context);
  }

  void showFeedback(BuildContext context, bool isCorrect) {
    final snackBar = SnackBar(
      content: Text(isCorrect ? 'Correct!' : 'Incorrect'),
      backgroundColor: isCorrect ? Colors.green : Colors.red,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void startTimer(BuildContext context) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        notifyListeners();
      } else {
        finishQuiz(context);
      }
    });
  }

  void answerQuestion(BuildContext context, int optionId) {
    if (userAnswers.containsKey(currentQuestionIndex)) {
      return;
    }

    userAnswers[currentQuestionIndex] = optionId;
    Question question = quiz.questions[currentQuestionIndex];
    Option selectedOption =
        question.options.firstWhere((o) => o.id == optionId);

    if (selectedOption.isCorrect) {
      score += 1;
    }

    showFeedback(context, selectedOption.isCorrect);

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < quiz.questions.length - 1) {
        currentQuestionIndex++;
        notifyListeners();
      } else {
        finishQuiz(context);
      }
    });
  }

  void finishQuiz([BuildContext? context]) {
    timer.cancel();
    if (context != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: quiz.questions.length,
            userAnswers: userAnswers,
            quiz: quiz,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
