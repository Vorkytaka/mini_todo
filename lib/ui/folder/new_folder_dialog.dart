import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../data/repository.dart';
import '../../entity/folder.dart';
import '../../generated/l10n.dart';

Future<void> showNewFolderDialog({required BuildContext context}) => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => const _NewFolderDialog(),
    );

class _NewFolderDialog extends StatefulWidget {
  const _NewFolderDialog({Key? key}) : super(key: key);

  @override
  State<_NewFolderDialog> createState() => _NewFolderDialogState();
}

class _NewFolderDialogState extends State<_NewFolderDialog> {
  String? title;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: mediaQuery.viewInsets + mediaQuery.padding + const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Material(
        color: theme.dialogBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            child: Row(
              children: [
                // todo: folder color
                // IconButton(
                //   onPressed: () {},
                //   icon: Ink(
                //     decoration: const BoxDecoration(
                //       color: Colors.blue,
                //       shape: BoxShape.circle,
                //     ),
                //   ),
                // ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Название папки',
                      counterText: '',
                    ),
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    maxLength: kFolderTitleMaxLength,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    initialValue: '',
                    validator: (title) {
                      if (title == null || title.isEmpty) {
                        return S.of(context).new_todo__title_required;
                      }

                      return null;
                    },
                    onSaved: (title) {
                      this.title = title;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Builder(
                    builder: (context) => IconButton(
                          onPressed: () {
                            final form = Form.of(context)!;
                            if (form.validate()) {
                              form.save();
                              context.read<Repository>().createFolder(FolderCarcass(title: title!));
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(Icons.done),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
