const String tableCategory = 'category';

class CategoryFields {
  static const List<String> values = [ id, description, type];
  static const String description = 'description';
  static const String type = 'type';
  static const String id = 'id';
}

class Category {
  String description;
  String type; // Category or Accounttype
  int? id;

  Category({this.id, required this.description, required this.type});

  Map<String, dynamic> toMap() {
    return {
      CategoryFields.id: id,
      CategoryFields.description: description,
      CategoryFields.type: type
    };
  }

  static Category fromMap(Map<String, Object?> map) => Category(
      id: map[CategoryFields.id] as int?,
      description: map[CategoryFields.description] as String,
      type: map[CategoryFields.type] as String);

  Category copy({int? id, String? description, String? type}) => Category(
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type);

  @override
  String toString() {
    return 'Transaction({id: $id, description: $description, type: $type}';
  }
}
