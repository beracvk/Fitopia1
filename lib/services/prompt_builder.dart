String buildMealPrompt(Map<String, dynamic> preferences) {
  final dietGoal = preferences['dietGoal'] ?? 'maintain weight';
  final allergies =
      (preferences['allergies'] as List<dynamic>?)?.join(', ') ?? 'none';
  final age = preferences['age']?.toString() ?? '30';
  final gender = preferences['gender'] ?? 'unspecified';
  final activity = preferences['activityLevel'] ?? 'moderate';

  return '''
You are a nutritionist AI assistant.

Create a 3-day healthy meal plan for a $age-year-old $gender aiming to $dietGoal.
Their activity level is $activity and they are allergic to: $allergies.

Please include breakfast, lunch, and dinner for each day.

The meals should be simple, healthy, and aligned with the user's goal and allergies.
''';
}

String buildExercisePrompt(Map<String, dynamic> preferences) {
  final goal = preferences['dietGoal'] ?? 'fit';
  final activity = preferences['activityLevel'] ?? 'moderate';
  final age = preferences['age'] ?? '30';
  final gender = preferences['gender'] ?? 'unspecified';

  return '''
You are a fitness coach AI assistant.

Please suggest a personalized workout plan for a $age-year-old $gender aiming for $goal.
Activity level: $activity

Include:
- 1 warm-up activity
- 2 strength exercises
- 1 cardio
- 1 stretching exercise

Use bodyweight if possible and keep it beginner-friendly.
  ''';
}
