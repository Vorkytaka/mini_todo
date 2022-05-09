import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/domain/folder/folder_cubit.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/todo_list.dart';
import 'package:mini_todo/utils/color.dart';

import '../new_todo.dart';

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
        data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSeed(seedColor: folder.color!)),
        child: screen,
      );
    }

    return screen;
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
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: Colors.grey.shade100,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showCompleted = !_showCompleted;
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(4)),
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
