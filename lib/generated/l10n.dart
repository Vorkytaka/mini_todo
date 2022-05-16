// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `miniTodo`
  String get app_name {
    return Intl.message(
      'miniTodo',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get common__inbox {
    return Intl.message(
      'Inbox',
      name: 'common__inbox',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get common__confirm {
    return Intl.message(
      'Confirm',
      name: 'common__confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get common__cancel {
    return Intl.message(
      'Cancel',
      name: 'common__cancel',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get common__all {
    return Intl.message(
      'All',
      name: 'common__all',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get common__yes {
    return Intl.message(
      'Yes',
      name: 'common__yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get common__no {
    return Intl.message(
      'No',
      name: 'common__no',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get common__yesterday {
    return Intl.message(
      'Yesterday',
      name: 'common__yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get common__today {
    return Intl.message(
      'Today',
      name: 'common__today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get common__tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'common__tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get common__completed {
    return Intl.message(
      'Completed',
      name: 'common__completed',
      desc: '',
      args: [],
    );
  }

  /// `Show completed`
  String get common__show_completed {
    return Intl.message(
      'Show completed',
      name: 'common__show_completed',
      desc: '',
      args: [],
    );
  }

  /// `Hide completed`
  String get common__hide_completed {
    return Intl.message(
      'Hide completed',
      name: 'common__hide_completed',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get folder__today {
    return Intl.message(
      'Today',
      name: 'folder__today',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get today_screen__overdue {
    return Intl.message(
      'Overdue',
      name: 'today_screen__overdue',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get new_todo_dialog__title_hint {
    return Intl.message(
      'Task',
      name: 'new_todo_dialog__title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter task title`
  String get new_todo_dialog__title_required {
    return Intl.message(
      'Enter task title',
      name: 'new_todo_dialog__title_required',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get datetime_dialog__time {
    return Intl.message(
      'Time',
      name: 'datetime_dialog__time',
      desc: '',
      args: [],
    );
  }

  /// `Delete this todo?`
  String get delete_todo_dialog__title {
    return Intl.message(
      'Delete this todo?',
      name: 'delete_todo_dialog__title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete `
  String get delete_todo_dialog__content {
    return Intl.message(
      'Are you sure you want to delete ',
      name: 'delete_todo_dialog__content',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone.`
  String get delete_todo_dialog__caution {
    return Intl.message(
      'This action cannot be undone.',
      name: 'delete_todo_dialog__caution',
      desc: '',
      args: [],
    );
  }

  /// `No date`
  String get todo_detailed_screen__no_date {
    return Intl.message(
      'No date',
      name: 'todo_detailed_screen__no_date',
      desc: '',
      args: [],
    );
  }

  /// `No time`
  String get todo_detailed_screen__no_time {
    return Intl.message(
      'No time',
      name: 'todo_detailed_screen__no_time',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get todo_detailed_screen__delete {
    return Intl.message(
      'Delete',
      name: 'todo_detailed_screen__delete',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get todo_detailed_screen__note_hint {
    return Intl.message(
      'Note',
      name: 'todo_detailed_screen__note_hint',
      desc: '',
      args: [],
    );
  }

  /// `Folder title`
  String get editable_folder_dialog__hint {
    return Intl.message(
      'Folder title',
      name: 'editable_folder_dialog__hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter folder title`
  String get editable_folder_dialog__title_error {
    return Intl.message(
      'Enter folder title',
      name: 'editable_folder_dialog__title_error',
      desc: '',
      args: [],
    );
  }

  /// `Update folder`
  String get folder_screen__update_folder {
    return Intl.message(
      'Update folder',
      name: 'folder_screen__update_folder',
      desc: '',
      args: [],
    );
  }

  /// `Delete folder`
  String get folder_screen__delete_folder {
    return Intl.message(
      'Delete folder',
      name: 'folder_screen__delete_folder',
      desc: '',
      args: [],
    );
  }

  /// `Folder is empty`
  String get folder_screen__empty_title {
    return Intl.message(
      'Folder is empty',
      name: 'folder_screen__empty_title',
      desc: '',
      args: [],
    );
  }

  /// `Don't be lazy,\nadd your first todo!`
  String get folder_screen__empty_caution {
    return Intl.message(
      'Don\'t be lazy,\nadd your first todo!',
      name: 'folder_screen__empty_caution',
      desc: '',
      args: [],
    );
  }

  /// `Delete folder?`
  String get delete_folder_dialog__title {
    return Intl.message(
      'Delete folder?',
      name: 'delete_folder_dialog__title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete folder `
  String get delete_folder_dialog__content {
    return Intl.message(
      'Are you sure you want to delete folder ',
      name: 'delete_folder_dialog__content',
      desc: '',
      args: [],
    );
  }

  /// `Also delete all todos from this folder`
  String get delete_folder_dialog__delete_todos_toggle {
    return Intl.message(
      'Also delete all todos from this folder',
      name: 'delete_folder_dialog__delete_todos_toggle',
      desc: '',
      args: [],
    );
  }

  /// `Create folder`
  String get folder_list_screen__create_folder_tooltip {
    return Intl.message(
      'Create folder',
      name: 'folder_list_screen__create_folder_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Create todo`
  String get folder_list_screen__create_todo_tooltip {
    return Intl.message(
      'Create todo',
      name: 'folder_list_screen__create_todo_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Select the folder`
  String get select_folder_dialog__title {
    return Intl.message(
      'Select the folder',
      name: 'select_folder_dialog__title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
