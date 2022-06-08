import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/utils/color.dart';

import '../../data/todo_repository.dart';
import '../../entity/todo.dart';
import '../../generated/l10n.dart';
import '../../utils/tuple.dart';
import '../common/gradient_body.dart';
import '../new_todo.dart';
import '../todo_list.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    final appBar = AppBar(
      centerTitle: false,
      title: Text(s.common__all_todos),
    );

    Widget body = BlocBuilder<FoldersCubit, List<Pair<Folder, int>>>(
      builder: (context, folders) {
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),
            ..._folder(context, Folder(id: null, title: s.common__inbox)),
            for (final folder in folders) ..._folder(context, folder.first),
          ],
        );
      },
    );

    body = GradientBody(
      color: Colors.indigo.lighten(70),
      child: body,
    );

    return Theme(
      data: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        toggleableActiveColor: Colors.indigo,
      ),
      child: Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () => showNewTodoDialog(context: context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  List<Widget> _folder(BuildContext context, Folder folder) {
    return [
      SliverToBoxAdapter(
        child: Center(
          child: TodoListHeader(
            child: Text(folder.title),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(8),
        sliver: StreamBuilder<List<Todo>>(
          initialData: const [],
          stream: context.read<TodoRepository>().streamTodosFromFolder(folder.id),
          builder: (context, snapshot) {
            if (snapshot.data!.isEmpty) return const SliverToBoxAdapter();
            return TodoList(todos: snapshot.data!);
          },
        ),
      ),
    ];
  }
}
