enum MealPrep {
  cooked,
  ordered,
}

extension GetName on MealPrep {
  String get displayName {
    switch (this) {
      case MealPrep.cooked:
        return "Cooked";
      case MealPrep.ordered:
        return "Ordered";
      default:
        return "";
    }
  }
}