import 'package:flutter/material.dart';

class AppStyles {
  // Color Scheme
  static const Color primaryColor = Color(0xFF6B4EFF);
  static const Color secondaryColor = Color(0xFF32B5FF);
  static const Color backgroundColor = Color(0xFFF8F9FE);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFFF4D4D);
  static const Color textPrimaryColor = Color(0xFF2D3142);
  static const Color textSecondaryColor = Color(0xFF9095A7);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
    letterSpacing: 0.5,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: textPrimaryColor,
  );

  static const TextStyle timerStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 2,
  );

  // Card Styles
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Progress Indicator Styles
  static final progressIndicatorTheme = ProgressIndicatorThemeData(
    color: primaryColor,
    linearTrackColor: Colors.grey[200],
  );

  // Common Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Option Card Style
  static BoxDecoration optionCardDecoration({bool isSelected = false, bool? isCorrect}) {
    Color backgroundColor = Colors.white;
    if (isSelected) {
      backgroundColor = isCorrect == null
          ? primaryColor.withOpacity(0.1)
          : isCorrect
              ? successColor.withOpacity(0.1)
              : errorColor.withOpacity(0.1);
    }

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? primaryColor : Colors.grey[300]!,
        width: 2,
      ),
    );
  }
}