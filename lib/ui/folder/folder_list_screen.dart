import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/folder/folder_screen.dart';
import 'package:mini_todo/ui/folder/new_folder_dialog.dart';
import 'package:mini_todo/ui/folder/today_screen.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNewTodoDialog(context: context),
        child: const Icon(Icons.add),
        tooltip: S.of(context).folder_list_screen__create_todo_tooltip,
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
                icon: const Icon(kDefaultInboxIcon),
              ),
            ),
            SliverToBoxAdapter(
              child: ListItem(
                icon: Stack(
                  alignment: const Alignment(0, 0.55),
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.green,
                    ),
                    Text(
                      '${CurrentTime.of(context).day}',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                          ),
                    )
                  ],
                ),
                title: Text(S.of(context).folder__today),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TodayScreen()),
                ),
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
            SliverToBoxAdapter(
              child: ListItem(
                icon: const Icon(Icons.add),
                title: Text(S.of(context).folder_list_screen__create_folder_tooltip),
                iconColor: Theme.of(context).primaryColor,
                titleColor: Theme.of(context).primaryColor,
                onTap: () => showNewFolderDialog(context: context),
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
      icon: icon ?? const Icon(kDefaultFolderIcon),
      iconColor: folder.color ?? Theme.of(context).primaryColor,
      title: Text(
        folder.title,
        maxLines: 1,
      ),
    );
  }
}
