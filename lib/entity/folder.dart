import 'dart:ui';

import 'package:meta/meta.dart';

@immutable
class Folder {
  final int? id;
  final String title;
  final Color? color;

  const Folder({
    required this.id,
    required this.title,
    this.color,
  });
}

@immutable
class FolderCarcass {
  final String title;
  final Color? color;

  const FolderCarcass({
    required this.title,
    this.color,
  });
}
