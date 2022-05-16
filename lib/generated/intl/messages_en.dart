// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("miniTodo"),
        "common__all": MessageLookupByLibrary.simpleMessage("All"),
        "common__cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "common__completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "common__confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "common__hide_completed": MessageLookupByLibrary.simpleMessage("Hide completed"),
        "common__inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "common__no": MessageLookupByLibrary.simpleMessage("No"),
        "common__show_completed": MessageLookupByLibrary.simpleMessage("Show completed"),
        "common__today": MessageLookupByLibrary.simpleMessage("Today"),
        "common__tomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
        "common__yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "common__yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
        "datetime_dialog__time": MessageLookupByLibrary.simpleMessage("Time"),
        "delete_folder_dialog__content":
            MessageLookupByLibrary.simpleMessage("Are you sure you want to delete folder "),
        "delete_folder_dialog__delete_todos_toggle":
            MessageLookupByLibrary.simpleMessage("Also delete all todos from this folder"),
        "delete_folder_dialog__title": MessageLookupByLibrary.simpleMessage("Delete folder?"),
        "delete_todo_dialog__caution": MessageLookupByLibrary.simpleMessage("This action cannot be undone."),
        "delete_todo_dialog__content": MessageLookupByLibrary.simpleMessage("Are you sure you want to delete "),
        "delete_todo_dialog__title": MessageLookupByLibrary.simpleMessage("Delete this todo?"),
        "editable_folder_dialog__hint": MessageLookupByLibrary.simpleMessage("Folder title"),
        "editable_folder_dialog__title_error": MessageLookupByLibrary.simpleMessage("Enter folder title"),
        "folder__today": MessageLookupByLibrary.simpleMessage("Today"),
        "folder_list_screen__create_folder_tooltip": MessageLookupByLibrary.simpleMessage("Create folder"),
        "folder_list_screen__create_todo_tooltip": MessageLookupByLibrary.simpleMessage("Create todo"),
        "folder_screen__delete_folder": MessageLookupByLibrary.simpleMessage("Delete folder"),
        "folder_screen__empty_caution": MessageLookupByLibrary.simpleMessage("Don\'t be lazy,\nadd your first todo!"),
        "folder_screen__empty_title": MessageLookupByLibrary.simpleMessage("Folder is empty"),
        "folder_screen__update_folder": MessageLookupByLibrary.simpleMessage("Update folder"),
        "new_todo_dialog__title_hint": MessageLookupByLibrary.simpleMessage("Task"),
        "new_todo_dialog__title_required": MessageLookupByLibrary.simpleMessage("Enter task title"),
        "select_folder_dialog__title": MessageLookupByLibrary.simpleMessage("Select the folder"),
        "today_screen__overdue": MessageLookupByLibrary.simpleMessage("Overdue"),
        "todo_detailed_screen__delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "todo_detailed_screen__no_date": MessageLookupByLibrary.simpleMessage("No date"),
        "todo_detailed_screen__no_time": MessageLookupByLibrary.simpleMessage("No time"),
        "todo_detailed_screen__note_hint": MessageLookupByLibrary.simpleMessage("Note")
      };
}
