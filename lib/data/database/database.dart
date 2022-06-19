import 'dart:io';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:mini_todo/data/database/table/folder_table.dart';
import 'package:mini_todo/data/database/table/subtodo_table.dart';
import 'package:mini_todo/data/database/table/todo_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    TodoTable,
    FolderTable,
    SubtodoTable,
  ],
  include: {'tables.drift'},
)
class Database extends _$Database {
  Database() : super(_openConnection());

  Database.connect(QueryExecutor connection) : super(connection);

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file, logStatements: kDebugMode);
    });
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          // Disable foreign_keys before migrations
          await customStatement('PRAGMA foreign_keys = OFF');

          // All migrations in one transaction
          await transaction(() async {
            // Goes from current to the new version
            for (int current = from; current < to; current++) {
              // Get the version to which we will migrate now
              final int target = current + 1;

              if (target == 2) {
                // In version 2 we add `notificationOffset`
                await migrator.addColumn(todoTable, todoTable.notificationOffset);

                // set zero offset for all todos with time
                final query = update(todoTable);
                query.where((tbl) => tbl.time.isNotNull());
                await query.write(const TodoTableCompanion(notificationOffset: Value(Duration.zero)));
              } else if(target == 3) {
                // In version 3 we add `completeTodoBySubtodos`
                await migrator.createTrigger(completeTodoBySubtodos);
              }
            }
          });

          // Assert that the schema is valid after migrations
          if (kDebugMode) {
            final wrongForeignKeys = await customSelect('PRAGMA foreign_key_check').get();
            assert(
              wrongForeignKeys.isEmpty,
              '${wrongForeignKeys.map((e) => e.data)}',
            );
          }
        },
        beforeOpen: (details) async {
          // Enable foreign_keys before open, but after migrations
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
