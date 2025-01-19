import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/styles.dart';

class QuizScreen extends StatelessWidget {
  final Quiz quiz;

  const QuizScreen({super.key, required this.quiz});

  Future<bool> _showExitQuizDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Quiz?'),
            content: const Text('Are you sure you want to exit the quiz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = QuizProvider();
        provider.initQuiz(context, quiz);
        return provider;
      },
      child: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          final currentQuestion =
              quizProvider.quiz.questions[quizProvider.currentQuestionIndex];

          return Scaffold(
            backgroundColor: AppStyles.backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                style: AppStyles.primaryButtonStyle,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _showExitQuizDialog(context),
              ),
              backgroundColor: AppStyles.primaryColor,
              elevation: 0,
              title: Text(quiz.title,
                  style: AppStyles.headingStyle.copyWith(color: Colors.white)),
              actions: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppStyles.paddingMedium),
                  decoration: BoxDecoration(
                    color: AppStyles.secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(AppStyles.paddingSmall),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(Icons.watch_later_outlined,
                            color: Colors.white),
                        const SizedBox(width: 5),
                        Text(
                          '${quizProvider.remainingTime ~/ 60}:${(quizProvider.remainingTime % 60).toString().padLeft(2, '0')}',
                          style: AppStyles.timerStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: (quizProvider.currentQuestionIndex + 1) /
                        quiz.questions.length,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Question ${quizProvider.currentQuestionIndex + 1}/${quiz.questions.length}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentQuestion.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        final option = currentQuestion.options[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: AppStyles.paddingSmall),
                          decoration: AppStyles.optionCardDecoration(
                            isSelected: quizProvider.userAnswers[
                                    quizProvider.currentQuestionIndex] ==
                                option.id,
                            isCorrect: option.isCorrect,
                          ),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.all(AppStyles.paddingMedium),
                            title: Text(
                              option.description,
                              style: AppStyles.bodyStyle,
                            ),
                            onTap: () =>
                                quizProvider.answerQuestion(context, option.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
