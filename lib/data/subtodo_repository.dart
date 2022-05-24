import 'package:drift/drift.dart';
import 'package:mini_todo/data/database/database.dart';
import 'package:mini_todo/data/database/table/subtodo_table.dart';

import '../entity/subtodo.dart';

abstract class SubtodoRepository {
  Stream<List<Subtodo>> streamByTodo(int todoId);

  Future<void> createForTodo(int todoId);

  Future<void> changeTitle(int id, String title);

  Future<void> changeCompleted(int id, bool completed);

  Future<void> delete(int id);
}

class SubtodoRepositoryImpl implements SubtodoRepository {
  final Database database;

  const SubtodoRepositoryImpl({required this.database});

  @override
  Stream<List<Subtodo>> streamByTodo(int todoId) {
    final query = database.select(database.subtodoTable);
    query.where((tbl) => tbl.todoId.equals(todoId));
    return query.map((p0) => p0.toSubtodo).watch();
  }

  @override
  Future<void> createForTodo(int todoId) {
    final query = database.into(database.subtodoTable);
    return query.insert(
      SubtodoTableCompanion.insert(
        title: '',
        todoId: todoId,
      ),
    );
  }

  @override
  Future<void> changeTitle(int id, String title) {
    final query = database.update(database.subtodoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(SubtodoTableCompanion(title: Value(title)));
  }

  @override
  Future<void> changeCompleted(int id, bool completed) {
    final query = database.update(database.subtodoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(SubtodoTableCompanion(completed: Value(completed)));
  }

  @override
  Future<void> delete(int id) {
    final query = database.delete(database.subtodoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.go();
  }
}
