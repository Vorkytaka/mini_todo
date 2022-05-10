import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/domain/folder/folder_cubit.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/todo_list.dart';
import 'package:mini_todo/utils/color.dart';

import '../new_todo.dart';
import '../../utils/collections.dart';

enum _MenuItem {
  edit,
  delete,
}

class FolderScreen extends StatelessWidget {
  final Folder folder;

  const FolderScreen({
    Key? key,
    required this.folder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget screen = BlocProvider<FolderCubit>(
      create: (context) => FolderCubit(
        folder: folder,
        repository: context.read(),
      ),
      lazy: false,
      child: BlocBuilder<FolderCubit, FolderState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(state.folder.title),
              actions: [
                if (folder.id != null)
                  PopupMenuButton<_MenuItem>(
                    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Изменить папку'),
                          minLeadingWidth: 0,
                          dense: true,
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.delete_outline),
                          title: Text('Удалить папку'),
                          minLeadingWidth: 0,
                          dense: true,
                          iconColor: Theme.of(context).errorColor,
                          textColor: Theme.of(context).errorColor,
                        ),
                        value: _MenuItem.delete,
                      ),
                    ],
                    onSelected: (item) async {
                      switch (item) {
                        case _MenuItem.edit:
                          break;
                        case _MenuItem.delete:
                          await showDeleteFolderDialog(context: context, folder: folder);
                          break;
                      }
                    },
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showNewTodoDialog(context: context, folder: state.folder),
              child: const Icon(Icons.add),
            ),
            body: Stack(
              children: [
                Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (state.folder.color ?? Theme.of(context).primaryColor).lighten(80),
                        Colors.grey.shade200,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                _Body(state: state),
              ],
            ),
          );
        },
      ),
    );

    if (folder.color != null) {
      screen = Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: folder.color!),
          toggleableActiveColor: folder.color!,
        ),
        child: screen,
      );
    }

    return BlocListener<FoldersCubit, List<Folder>>(
      listener: (context, state) {
        final folder = state.firstOrNull((folder) => folder.id == folder.id);
        if(folder == null) {
          Navigator.of(context).pop();
        }
      },
      child: screen,
    );
  }
}

class _Body extends StatelessWidget {
  final FolderState state;

  const _Body({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (state.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.playlist_add,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'Сейчас список пуст',
            textAlign: TextAlign.center,
            style: theme.textTheme.headline5,
          ),
          const SizedBox(height: 16),
          Text(
            'Добавьте первую задачу,\nне ленитесь!',
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1,
          ),
        ],
      );
    }

    return _TodosList(state: state);
  }
}

class _TodosList extends StatefulWidget {
  final FolderState state;

  const _TodosList({Key? key, required this.state}) : super(key: key);

  @override
  State<_TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<_TodosList> {
  bool _showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          sliver: TodoList(todos: widget.state.todos),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Material(
              borderRadius: borderRadius,
              color: Colors.grey.shade100,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showCompleted = !_showCompleted;
                  });
                },
                borderRadius: borderRadius,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    _showCompleted ? S.of(context).common_hide_completed : S.of(context).common_show_completed,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_showCompleted)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            sliver: TodoList(todos: widget.state.completed),
          ),
      ],
    );
  }
}

Future<void> showDeleteFolderDialog({
  required BuildContext context,
  required Folder folder,
}) =>
    showDialog(
      context: context,
      builder: (context) => DeleteFolderDialog(folder: folder),
    );

class DeleteFolderDialog extends StatefulWidget {
  final Folder folder;

  const DeleteFolderDialog({
    Key? key,
    required this.folder,
  }) : super(key: key);

  @override
  State<DeleteFolderDialog> createState() => _DeleteFolderDialogState();
}

class _DeleteFolderDialogState extends State<DeleteFolderDialog> {
  bool _deleteTodos = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить папку?'),
      contentPadding: const EdgeInsets.only(left: 24, top: 20, right: 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: 'Вы действительно хотите удалить папку '),
                TextSpan(text: widget.folder.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: '?'),
              ],
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(height: 24),
          CheckboxListTile(
            tristate: false,
            value: _deleteTodos,
            onChanged: (checked) => setState(() {
              _deleteTodos = checked!;
            }),
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'Удалить все задачи из папки',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).common__no),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
          onPressed: () async {
            await context.read<Repository>().deleteFolder(widget.folder.id!, _deleteTodos);
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).common__yes),
        ),
      ],
    );
  }
}
