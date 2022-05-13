import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/folder/folder_screen.dart';
import 'package:mini_todo/ui/folder/new_folder_dialog.dart';
import 'package:mini_todo/ui/new_todo.dart';

import '../list_item.dart';

class FolderListScreen extends StatelessWidget {
  const FolderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: () => showNewFolderDialog(context: context),
            heroTag: null,
            child: const Icon(Icons.create_new_folder_outlined),
            tooltip: S.of(context).folder_list_screen__create_folder_tooltip,
            shape: const RoundedRectangleBorder(borderRadius: borderRadiusMedium),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => showNewTodoDialog(context: context),
            child: const Icon(Icons.add),
            tooltip: S.of(context).folder_list_screen__create_todo_tooltip,
          ),
        ],
      ),
      body: const FolderListWidget(),
    );
  }
}

class FolderListWidget extends StatelessWidget {
  const FolderListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoldersCubit, List<Folder>>(
      builder: (context, folders) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FolderItemWidget(
                folder: Folder(
                  id: null,
                  title: S.of(context).common__inbox,
                ),
                icon: const Icon(Icons.inbox_outlined),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => FolderItemWidget(
                  folder: folders[i],
                ),
                childCount: folders.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

class FolderItemWidget extends StatelessWidget {
  final Folder folder;
  final Widget? icon;

  const FolderItemWidget({
    Key? key,
    required this.folder,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FolderScreen(folder: folder)),
      ),
      icon: icon ?? const Icon(Icons.folder_outlined),
      iconColor: folder.color ?? Theme.of(context).primaryColor,
      title: Text(
        folder.title,
        maxLines: 1,
      ),
    );
  }
}
