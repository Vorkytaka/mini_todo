import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:mini_todo/constants.dart';

class FolderTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: kFolderTitleMaxLength)();

  IntColumn get color => integer().map(const ColorConverter()).nullable()();
}

class ColorConverter implements TypeConverter<Color, int> {
  const ColorConverter();

  @override
  Color? mapToDart(int? fromDb) {
    if (fromDb == null) return null;
    return Color(fromDb);
  }

  @override
  int? mapToSql(Color? value) {
    if (value == null) return null;
    return value.value;
  }
}
