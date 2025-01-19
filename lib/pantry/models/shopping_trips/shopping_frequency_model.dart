enum ShoppingFrequency {
  weekly,
  fortnightly,
  monthly,
}

extension GetName on ShoppingFrequency {
  String get displayName {
    switch (this) {
      case ShoppingFrequency.weekly:
        return 'Weekly';
      case ShoppingFrequency.fortnightly:
        return 'Fortnightly';
      case ShoppingFrequency.monthly:
        return 'Monthly';
      default:
        return '';
    }
  }
}

extension GetInterval on ShoppingFrequency {
  Duration get interval {
    switch (this) {
      case ShoppingFrequency.weekly:
        return const Duration(days: 7);
      case ShoppingFrequency.fortnightly:
        return const Duration(days: 14);
      case ShoppingFrequency.monthly:
        return const Duration(days: 28);
    }
  }
}

