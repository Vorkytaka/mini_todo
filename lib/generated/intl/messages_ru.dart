// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "common__all": MessageLookupByLibrary.simpleMessage("Все"),
        "common__cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "common__confirm": MessageLookupByLibrary.simpleMessage("Принять"),
        "common__inbox": MessageLookupByLibrary.simpleMessage("Входящие"),
        "common_completed": MessageLookupByLibrary.simpleMessage("Выполненные"),
        "common_today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "common_tomorrow": MessageLookupByLibrary.simpleMessage("Завтра"),
        "common_yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
        "datetime_dialog__time": MessageLookupByLibrary.simpleMessage("Время"),
        "new_todo__title_hint": MessageLookupByLibrary.simpleMessage("Задача..."),
        "new_todo__title_required": MessageLookupByLibrary.simpleMessage("Введите название задачи")
      };
}
