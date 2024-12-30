enum MealTime {
  breakfast,
  lunch,
  dinner,
}

extension getName on MealTime {
  String get displayName {
    switch (this) {
      case MealTime.breakfast:
        return 'Breakfast';
      case MealTime.lunch:
        return 'Lunch';
      case MealTime.dinner:
        return 'Dinner';
      default:
        return '';
    }
  }
}