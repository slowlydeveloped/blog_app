class TodoModel {
  final int? id;
  final String title;
  final String content;
  final String? createdAt;
  final bool isDone = false;

  TodoModel({
     this.id,
    required this.title,
    required this.content,
     this.createdAt,
    isDone = false,
  });

  factory TodoModel.fromDatabaseJson(Map<String, dynamic> data) => TodoModel(
        id: data['id'],
        title: data['title'],
        content: data['content'],
        createdAt: data['createdAt'],
        isDone: data['isDone'] == 0 ? true : false,
      );
  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "title": title,
        "content": content,
        'createdAt': createdAt,
        "isDone": isDone == false ? 0 : 1,
      };
}
