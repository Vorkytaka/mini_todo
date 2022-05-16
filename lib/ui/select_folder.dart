import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../domain/folders/folders_cubit.dart';
import '../entity/folder.dart';
import '../generated/l10n.dart';

Future<Folder?> showSelectFolderDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      return BlocBuilder<FoldersCubit, List<Folder>>(
        builder: (context, folders) => SimpleDialog(
          title: Text(S.of(context).select_folder_dialog__title),
          children: [
            ListTile(
              leading: const Icon(kDefaultInboxIcon),
              title: Text(S.of(context).common__inbox),
              iconColor: theme.primaryColor,
              onTap: () => Navigator.of(context).pop(
                Folder(
                  id: null,
                  title: S.of(context).common__inbox,
                ),
              ),
            ),
            for (final folder in folders)
              ListTile(
                leading: const Icon(kDefaultFolderIcon),
                title: Text(folder.title),
                iconColor: folder.color ?? theme.primaryColor,
                onTap: () => Navigator.of(context).pop(folder),
              ),
          ],
        ),
      );
    },
  );
}
