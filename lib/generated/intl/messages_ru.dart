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

  static String m0(count) =>
      "${Intl.plural(count, zero: 'Без дней', one: 'Напомнить за ${count} день', two: 'Напомнить за ${count} дня', few: 'Напомнить за ${count} дня', other: 'Напомнить за ${count} дней')}";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'Без часов', one: 'Напомнить за ${count} час', two: 'Напомнить за ${count} часа', few: 'Напомнить за ${count} часа', other: 'Напомнить за ${count} часов')}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'Без минут', one: 'Напомнить за ${count} минуту', two: 'Напомнить за ${count} минуты', few: 'Напомнить за ${count} минуты', other: 'Напомнить за ${count} минут')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "common__all": MessageLookupByLibrary.simpleMessage("Все"),
        "common__all_todos": MessageLookupByLibrary.simpleMessage("Все задачи"),
        "common__cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "common__completed":
            MessageLookupByLibrary.simpleMessage("Выполненные"),
        "common__confirm": MessageLookupByLibrary.simpleMessage("Принять"),
        "common__hide_completed":
            MessageLookupByLibrary.simpleMessage("Скрыть выполненные"),
        "common__inbox": MessageLookupByLibrary.simpleMessage("Входящие"),
        "common__no": MessageLookupByLibrary.simpleMessage("Нет"),
        "common__show_completed":
            MessageLookupByLibrary.simpleMessage("Показать выполненные"),
        "common__today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "common__tomorrow": MessageLookupByLibrary.simpleMessage("Завтра"),
        "common__yes": MessageLookupByLibrary.simpleMessage("Да"),
        "common__yesterday": MessageLookupByLibrary.simpleMessage("Вчера"),
        "datetime_dialog__time": MessageLookupByLibrary.simpleMessage("Время"),
        "delete_folder_dialog__content": MessageLookupByLibrary.simpleMessage(
            "Вы точно хотите удалить папку "),
        "delete_folder_dialog__delete_todos_toggle":
            MessageLookupByLibrary.simpleMessage("Удалить все задачи из папки"),
        "delete_folder_dialog__title":
            MessageLookupByLibrary.simpleMessage("Удалить папку?"),
        "delete_todo_dialog__caution": MessageLookupByLibrary.simpleMessage(
            "Это действие нельзя отменить."),
        "delete_todo_dialog__content":
            MessageLookupByLibrary.simpleMessage("Вы точно хотите удалить "),
        "delete_todo_dialog__title":
            MessageLookupByLibrary.simpleMessage("Удалить задачу?"),
        "editable_folder_dialog__hint":
            MessageLookupByLibrary.simpleMessage("Название папки"),
        "editable_folder_dialog__title_error":
            MessageLookupByLibrary.simpleMessage("Введите название папки"),
        "folder__today": MessageLookupByLibrary.simpleMessage("Сегодня"),
        "folder_list_screen__create_folder_tooltip":
            MessageLookupByLibrary.simpleMessage("Создать папку"),
        "folder_list_screen__create_todo_tooltip":
            MessageLookupByLibrary.simpleMessage("Создать задачу"),
        "folder_screen__delete_folder":
            MessageLookupByLibrary.simpleMessage("Удалить папку"),
        "folder_screen__empty_caution": MessageLookupByLibrary.simpleMessage(
            "Не ленись, добавь первую задачу!"),
        "folder_screen__empty_title":
            MessageLookupByLibrary.simpleMessage("Здесь пусто"),
        "folder_screen__update_folder":
            MessageLookupByLibrary.simpleMessage("Изменить папку"),
        "new_todo_dialog__snackbar_action":
            MessageLookupByLibrary.simpleMessage("ОТКРЫТЬ"),
        "new_todo_dialog__snackbar_text":
            MessageLookupByLibrary.simpleMessage(" добавлено в папку "),
        "new_todo_dialog__title_hint":
            MessageLookupByLibrary.simpleMessage("Задача"),
        "new_todo_dialog__title_required":
            MessageLookupByLibrary.simpleMessage("Введите название задачи"),
        "select_folder_dialog__title":
            MessageLookupByLibrary.simpleMessage("Выберите папку"),
        "select_notification_offset__1_day":
            MessageLookupByLibrary.simpleMessage("За 1 день"),
        "select_notification_offset__1_hour":
            MessageLookupByLibrary.simpleMessage("За 1 час"),
        "select_notification_offset__30_mins":
            MessageLookupByLibrary.simpleMessage("За 30 минут"),
        "select_notification_offset__in_time":
            MessageLookupByLibrary.simpleMessage("Во время"),
        "select_notification_offset__no_notification":
            MessageLookupByLibrary.simpleMessage("Без уведомления"),
        "select_notification_offset__title":
            MessageLookupByLibrary.simpleMessage("Уведомление"),
        "today_screen__overdue":
            MessageLookupByLibrary.simpleMessage("Просроченные"),
        "todo_detailed_screen__add_subtodo":
            MessageLookupByLibrary.simpleMessage("Добавить подзадачу"),
        "todo_detailed_screen__delete":
            MessageLookupByLibrary.simpleMessage("Удалить"),
        "todo_detailed_screen__no_date":
            MessageLookupByLibrary.simpleMessage("Без даты"),
        "todo_detailed_screen__no_time":
            MessageLookupByLibrary.simpleMessage("Без времени"),
        "todo_detailed_screen__note_hint":
            MessageLookupByLibrary.simpleMessage("Заметка"),
        "todo_detailed_screen__notification_days": m0,
        "todo_detailed_screen__notification_hours": m1,
        "todo_detailed_screen__notification_in_time":
            MessageLookupByLibrary.simpleMessage("Напомнить во время"),
        "todo_detailed_screen__notification_minutes": m2,
        "todo_detailed_screen__notification_without":
            MessageLookupByLibrary.simpleMessage("Без напоминания"),
        "todo_detailed_screen__subtodo_hint":
            MessageLookupByLibrary.simpleMessage("Подзадача")
      };
}
