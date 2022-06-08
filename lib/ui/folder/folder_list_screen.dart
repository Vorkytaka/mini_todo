import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/data/folder_repository.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/folder/folder_screen.dart';
import 'package:mini_todo/ui/folder/new_folder_dialog.dart';
import 'package:mini_todo/ui/folder/today_screen.dart';
import 'package:mini_todo/ui/new_todo.dart';

import '../../utils/tuple.dart';
import '../list_item.dart';
import 'all_todo_screen.dart';

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
    return BlocBuilder<FoldersCubit, List<Pair<Folder, int>>>(
      builder: (context, folders) {
        final theme = Theme.of(context);

        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<int>(
                stream: context.read<FolderRepository>().streamInboxTodoCount(),
                initialData: 0,
                builder: (context, snapshot) {
                  final count = snapshot.data!;
                  return FolderItemWidget(
                    folder: Folder(
                      id: null,
                      title: S.of(context).common__inbox,
                    ),
                    todoCount: count,
                    icon: const Icon(kDefaultInboxIcon),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverToBoxAdapter(
              child: ListItem(
                icon: const Icon(
                  Icons.folder_copy,
                  color: Colors.indigo,
                ),
                title: Text(S.of(context).common__all_todos),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AllTodoScreen()),
                ),
                trailing: StreamBuilder<int>(
                  stream: context.read<FolderRepository>().streamAllTodoCount(),
                  initialData: 0,
                  builder: (context, snapshot) {
                    final count = snapshot.data!;
                    return Text(
                      '$count',
                      textAlign: TextAlign.end,
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.hintColor),
                    );
                  },
                ),
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
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.25,
                      ),
                    )
                  ],
                ),
                title: Text(S.of(context).folder__today),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TodayScreen()),
                ),
                trailing: StreamBuilder<int>(
                  stream: context.read<FolderRepository>().streamTodayTodoCount(),
                  initialData: 0,
                  builder: (context, snapshot) {
                    final count = snapshot.data!;
                    return Text(
                      '$count',
                      textAlign: TextAlign.end,
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.hintColor),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => FolderItemWidget(
                  folder: folders[i].first,
                  todoCount: folders[i].second,
                ),
                childCount: folders.length,
              ),
            ),
            SliverToBoxAdapter(
              child: ListItem(
                icon: const Icon(Icons.add),
                title: Text(S.of(context).folder_list_screen__create_folder_tooltip),
                iconColor: theme.primaryColor,
                titleColor: theme.primaryColor,
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
  final int todoCount;
  final Widget? icon;

  const FolderItemWidget({
    Key? key,
    required this.folder,
    required this.todoCount,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListItem(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FolderScreen(folder: folder)),
      ),
      icon: icon ?? const Icon(kDefaultFolderIcon),
      iconColor: folder.color ?? theme.primaryColor,
      title: Text(
        folder.title,
        maxLines: 1,
      ),
      trailing: Text(
        '$todoCount',
        textAlign: TextAlign.end,
        style: theme.textTheme.labelMedium?.copyWith(color: theme.hintColor),
      ),
    );
  }
}
