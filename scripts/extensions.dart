extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toCamelCase() {
    final words = split('_');
    if (words.isEmpty) return this;

    return words.first +
        words
            .skip(1)
            .map((word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : '')
            .join();
  }

  String toPascalCase() {
    if (isEmpty) return '';

    final words = split('_');
    return words
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join();
  }
}
