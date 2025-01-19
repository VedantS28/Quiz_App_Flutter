import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/services/quiz_service.dart';
import 'package:quiz_app/styles.dart';

class HomeScreen extends StatelessWidget {
  final QuizService quizService = QuizService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        elevation: 0,
        title: Text('Quiz App',
            style: AppStyles.headingStyle.copyWith(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppStyles.primaryColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: FutureBuilder<Quiz>(
          future: quizService.fetchQuiz(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppStyles.primaryColor),
                    ),
                    SizedBox(height: AppStyles.paddingMedium),
                    Text('Loading Quiz...', style: AppStyles.bodyStyle),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(AppStyles.paddingLarge),
                  decoration: AppStyles.cardDecoration,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: AppStyles.errorColor),
                      const SizedBox(height: AppStyles.paddingMedium),
                      const Text('Oops! Something went wrong',
                          style: AppStyles.subheadingStyle),
                      const SizedBox(height: AppStyles.paddingSmall),
                      Text(snapshot.error.toString(),
                          style: AppStyles.bodyStyle),
                    ],
                  ),
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                  child: Text('No quiz available', style: AppStyles.bodyStyle));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppStyles.paddingLarge),
                child: Column(
                  children: [
                    const SizedBox(height: AppStyles.paddingLarge),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppStyles.paddingLarge),
                      decoration: AppStyles.cardDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.title,
                            style: AppStyles.headingStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppStyles.paddingMedium),
                          _buildInfoRow(
                              Icons.topic, 'Topic', snapshot.data!.topic),
                          const SizedBox(height: AppStyles.paddingMedium),
                          _buildInfoRow(Icons.timer, 'Duration',
                              '${snapshot.data!.duration} minutes'),
                          const SizedBox(height: AppStyles.paddingLarge),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QuizScreen(quiz: snapshot.data!),
                                  ),
                                );
                              },
                              style: AppStyles.primaryButtonStyle,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Start Quiz'),
                                  SizedBox(width: AppStyles.paddingSmall),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppStyles.primaryColor),
        const SizedBox(width: AppStyles.paddingSmall),
        Text('$label: ',
            style: AppStyles.bodyStyle.copyWith(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value, style: AppStyles.bodyStyle),
        ),
      ],
    );
  }
}
