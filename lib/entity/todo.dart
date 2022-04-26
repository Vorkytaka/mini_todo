class Todo {
  final int id;
  final String title;
  final bool completed;
  final DateTime? date;
  final int? time;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
    this.date,
    this.time,
  });

  @override
  String toString() => 'Todo($id, $title)';
}
