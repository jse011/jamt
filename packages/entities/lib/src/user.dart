class User {
  const User({
    required this.document,
    this.year,
    this.name
  });

  final String document;
  final String? year;
  final String? name;

  static const empty = User(
    document: ""
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          document == other.document &&
          year == other.year &&
          name == other.name;

  @override
  int get hashCode => document.hashCode ^ year.hashCode ^ name.hashCode;
}