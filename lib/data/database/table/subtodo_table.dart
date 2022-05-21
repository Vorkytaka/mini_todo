import 'package:drift/drift.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/data/database/database.dart';

import '../../../entity/subtodo.dart';

class SubtodoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(max: kSubtodoTitleMaxLength)();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  IntColumn get todoId => integer()();
}

extension SubtodoTableUtils on SubtodoTableData {
  Subtodo get toSubtodo => Subtodo(
        id: id,
        title: title,
        completed: completed,
      );
}
