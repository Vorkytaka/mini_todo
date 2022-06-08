import 'package:drift/drift.dart';
import 'package:mini_todo/data/database/database.dart';
import 'package:mini_todo/data/database/table/folder_table.dart';
import 'package:mini_todo/utils/tuple.dart';

import '../entity/folder.dart';

abstract class FolderRepository {
  Future<void> create(FolderCarcass folder);

  Stream<List<Pair<Folder, int>>> streamAll();

  Future<void> update(Folder folder);

  Future<void> delete(int folderId, bool deleteTodos);

  Stream<int> streamInboxTodoCount();

  Stream<int> streamTodayTodoCount();

  Stream<int> streamAllTodoCount();
}

class FolderRepositoryImpl implements FolderRepository {
  final Database database;

  const FolderRepositoryImpl({required this.database});

  @override
  Future<void> create(FolderCarcass folder) {
    final query = database.into(database.folderTable);
    return query.insert(
      FolderTableCompanion.insert(
        title: folder.title,
        color: Value(folder.color),
      ),
    );
  }

  @override
  Stream<List<Pair<Folder, int>>> streamAll() {
    // todo: use counting
    final query = database.select(database.folderTable).join([
      leftOuterJoin(
        database.todoTable,
        database.todoTable.folderId.equalsExp(database.folderTable.id) & database.todoTable.completed.equals(false),
        useColumns: false,
      ),
    ]);
    query.addColumns([database.todoTable.id.count()]);
    query.groupBy([database.folderTable.id]);
    return query.map((p0) {
      return Pair(
        p0.readTable(database.folderTable).toFolder,
        p0.read(database.todoTable.id.count()),
      );
    }).watch();
  }

  @override
  Future<void> update(Folder folder) {
    assert(folder.id != null);
    final query = database.update(database.folderTable);
    query.where((tbl) => tbl.id.equals(folder.id));
    return query.write(FolderTableCompanion(
      title: Value(folder.title),
      color: Value(folder.color),
    ));
  }

  @override
  Future<void> delete(int folderId, bool deleteTodos) {
    return database.transaction(() async {
      if (deleteTodos) {
        final query = database.delete(database.todoTable);
        query.where((tbl) => tbl.folderId.equals(folderId));
        await query.go();
      } else {
        final query = database.update(database.todoTable);
        query.where((tbl) => tbl.folderId.equals(folderId));
        await query.write(const TodoTableCompanion(folderId: Value(null)));
      }

      final query = database.delete(database.folderTable);
      query.where((tbl) => tbl.id.equals(folderId));
      await query.go();
    });
  }

  @override
  Stream<int> streamInboxTodoCount() {
    final query = database.selectOnly(database.todoTable);
    query.where(database.todoTable.folderId.isNull());
    query.where(database.todoTable.completed.equals(false));
    query.addColumns([database.todoTable.id.count()]);
    return query.map((p0) => p0.read(database.todoTable.id.count())).watchSingle();
  }

  @override
  Stream<int> streamAllTodoCount() {
    final query = database.selectOnly(database.todoTable);
    query.where(database.todoTable.completed.equals(false));
    query.addColumns([database.todoTable.id.count()]);
    return query.map((p0) => p0.read(database.todoTable.id.count())).watchSingle();
  }

  @override
  Stream<int> streamTodayTodoCount() {
    final query = database.selectOnly(database.todoTable);
    query.where(database.todoTable.date.equalsValue(DateTime.now()));
    query.where(database.todoTable.completed.equals(false));
    query.addColumns([database.todoTable.id.count()]);
    return query.map((p0) => p0.read(database.todoTable.id.count())).watchSingle();
  }
}
