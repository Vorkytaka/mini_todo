import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mini_todo/data/database/database.dart';
import 'package:mini_todo/data/folder_repository.dart';
import 'package:mini_todo/data/notification/notification_repository.dart';
import 'package:mini_todo/data/subtodo_repository.dart';
import 'package:mini_todo/data/todo_repository.dart';
import 'package:mini_todo/data/todo_repository_impl.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';

import 'current_time_widget.dart';

class OuterDependencies extends StatelessWidget {
  final FlutterLocalNotificationsPlugin notificationPlugin;
  final Widget child;

  const OuterDependencies({
    Key? key,
    required this.child,
    required this.notificationPlugin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Database>(
          create: (context) => Database(),
          lazy: false,
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<FolderRepository>(
            create: (context) => FolderRepositoryImpl(database: context.read()),
          ),
          RepositoryProvider<TodoRepository>(
            create: (context) => TodoRepositoryImpl(database: context.read()),
          ),
          RepositoryProvider<SubtodoRepository>(
            create: (context) => SubtodoRepositoryImpl(database: context.read()),
          ),
          RepositoryProvider<NotificationRepository>(
            create: (context) => NotificationRepositoryImpl(plugin: notificationPlugin),
          ),
        ],
        child: BlocProvider<FoldersCubit>(
          create: (context) => FoldersCubit(folderRepository: context.read()),
          lazy: false,
          child: child,
        ),
      ),
    );
  }
}

class InnerDependencies extends StatelessWidget {
  final Widget child;

  const InnerDependencies({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurrentTimeUpdater(
      duration: const Duration(seconds: 30),
      child: ScrollConfiguration(
        behavior: const _ScrollBehavior(),
        child: child,
      ),
    );
  }
}

class _ScrollBehavior extends ScrollBehavior {
  const _ScrollBehavior() : super();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
