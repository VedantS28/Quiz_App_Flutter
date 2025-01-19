import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/styles.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Map<int, int> userAnswers;
  final Quiz quiz;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    const maxScore = 10.0;
    final percentage = (score / maxScore * 100).clamp(0, 100);

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        elevation: 0,
        title: Text('Quiz Results',
            style: AppStyles.headingStyle.copyWith(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppStyles.backgroundColor, Colors.white],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppStyles.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Quiz Completed!', style: AppStyles.headingStyle),
                const SizedBox(height: AppStyles.paddingLarge),
                Container(
                  padding: const EdgeInsets.all(AppStyles.paddingLarge),
                  decoration: AppStyles.cardDecoration,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 15,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                TweenAnimationBuilder(
                                  tween: Tween<double>(
                                      begin: 0, end: percentage / 100),
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                  builder: (context, double value, child) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: CircularProgressIndicator(
                                        value: value,
                                        backgroundColor: Colors.grey[100],
                                        strokeWidth: 15,
                                        valueColor: AlwaysStoppedAnimation(
                                          percentage >= 70
                                              ? AppStyles.successColor
                                              : percentage >= 40
                                                  ? Colors.blueAccent
                                                  : AppStyles.errorColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Inner circle with score
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${percentage.toStringAsFixed(1)}%',
                                        style: AppStyles.headingStyle.copyWith(
                                          fontSize: 32,
                                          color: percentage >= 70
                                              ? AppStyles.successColor
                                              : percentage >= 40
                                                  ? Colors.blueAccent
                                                  : AppStyles.errorColor,
                                        ),
                                      ),
                                      Text(
                                        'Score',
                                        style: AppStyles.bodyStyle.copyWith(
                                          color: AppStyles.textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Score: $score/${maxScore.toInt()}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Correct Answers: ${userAnswers.entries.where((e) => quiz.questions[e.key].options.firstWhere((o) => o.id == e.value).isCorrect).length}/$totalQuestions',
                        style: const TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppStyles.paddingLarge),
                ElevatedButton(
                  style: AppStyles.primaryButtonStyle,
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
