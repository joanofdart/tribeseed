class Utilities {
  Utilities._();

  static T enumToString<T>(
      Iterable<T> enumValueToConvert, String valueToCompare) {
    return enumValueToConvert.firstWhere(
      (enumValue) => enumValue.toString() == valueToCompare,
      orElse: () => null,
    );
  }
}
