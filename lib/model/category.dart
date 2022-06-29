const String tableCategory = 'category';

class CategoryFields {
  static const List<String> values = ['id', description, type];
  static const String description = 'description';
  static const String type = 'type';
  static const String id = '_id';
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

  @override
  String toString() {
    return 'Transaction({id: $id, description: $description, type: $type}';
  }
}
