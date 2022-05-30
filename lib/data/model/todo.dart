class TodoFields {
  static const String id = '_id';
  static const String todo = 'todo';
  static const String description = 'descrtiption';
  static const String isComplete = 'is_complete';

  static const List<String> values = [id, todo, description, isComplete];
}

class Todo {
  int? id;
  String? todo;
  String? description;
  bool isComplete;

  Todo({this.id, this.todo, this.description, required this.isComplete});

  Todo copy({int? id, String? todo, String? description, bool? isComplete}) =>
      Todo(
          id: id ?? this.id,
          todo: todo ?? this.todo,
          description: description ?? this.description,
          isComplete: isComplete ?? this.isComplete);

  static Todo fromMap(Map<String, Object?> map) => Todo(
        id: map[TodoFields.id] as int?,
        todo: map[TodoFields.todo] as String,
        description: map[TodoFields.description] as String,
        isComplete: map[TodoFields.isComplete] == 1,
      );

  Map<String, Object?> toMap() => {
        TodoFields.id: id,
        TodoFields.todo: todo,
        TodoFields.description: description,
        TodoFields.isComplete: isComplete ? 1 : 0
      };
}
