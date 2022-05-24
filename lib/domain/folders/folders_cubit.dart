import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/folder_repository.dart';
import 'package:mini_todo/entity/folder.dart';

import '../../utils/collections.dart';

class FoldersCubit extends Cubit<List<Folder>> {
  StreamSubscription? _subscription;

  FoldersCubit({
    required FolderRepository folderRepository,
  }) : super(const []) {
    _subscription = folderRepository.streamAll().listen((folders) {
      emit(folders);
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}

extension ListFoldersUtils on List<Folder> {
  Folder? byId(int? id) => id == null ? null : firstOrNull((folder) => folder.id == id);
}
