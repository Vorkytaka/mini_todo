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
  String get common_yesterday {
    return Intl.message(
      'Yesterday',
      name: 'common_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get common_today {
    return Intl.message(
      'Today',
      name: 'common_today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get common_tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'common_tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get common_completed {
    return Intl.message(
      'Completed',
      name: 'common_completed',
      desc: '',
      args: [],
    );
  }

  /// `Show completed`
  String get common_show_completed {
    return Intl.message(
      'Show completed',
      name: 'common_show_completed',
      desc: '',
      args: [],
    );
  }

  /// `Hide completed`
  String get common_hide_completed {
    return Intl.message(
      'Hide completed',
      name: 'common_hide_completed',
      desc: '',
      args: [],
    );
  }

  /// `Task...`
  String get new_todo__title_hint {
    return Intl.message(
      'Task...',
      name: 'new_todo__title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter task title`
  String get new_todo__title_required {
    return Intl.message(
      'Enter task title',
      name: 'new_todo__title_required',
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
  String get delete_todo__title {
    return Intl.message(
      'Delete this todo?',
      name: 'delete_todo__title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete `
  String get delete_todo__content {
    return Intl.message(
      'Are you sure you want to delete ',
      name: 'delete_todo__content',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone.`
  String get delete_todo__caution {
    return Intl.message(
      'This action cannot be undone.',
      name: 'delete_todo__caution',
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
