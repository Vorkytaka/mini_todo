import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/ui/color_picker.dart';

import '../../constants.dart';
import '../../data/repository.dart';
import '../../entity/folder.dart';

Future<void> showNewFolderDialog({required BuildContext context}) => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => _EditableHabitDialog(
        onConfirm: (folder) async {
          await context.read<Repository>().createFolder(folder);
          Navigator.of(context).pop();
        },
      ),
    );

Future<void> showEditFolderDialog({
  required BuildContext context,
  required Folder folder,
}) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => _EditableHabitDialog(
        folder: folder,
        onConfirm: (carcass) async {
          final newFolder = Folder(
            id: folder.id,
            title: carcass.title,
            color: carcass.color,
          );
          await context.read<Repository>().updateFolder(newFolder);
          Navigator.of(context).pop();
        },
      ),
    );

typedef _OnConfirm = void Function(FolderCarcass carcass);

class _EditableHabitDialog extends StatefulWidget {
  final Folder? folder;
  final _OnConfirm onConfirm;

  const _EditableHabitDialog({
    Key? key,
    this.folder,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<_EditableHabitDialog> createState() => _EditableHabitDialogState();
}

class _EditableHabitDialogState extends State<_EditableHabitDialog> {
  String? _title;
  Color? _color;

  @override
  void initState() {
    super.initState();
    _title = widget.folder?.title;
    _color = widget.folder?.color;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: mediaQuery.viewInsets + mediaQuery.padding + const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Material(
        color: theme.dialogBackgroundColor,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            child: Row(
              children: [
                ColorPickerOverlayField(
                  offset: const Offset(0, 56),
                  initialValue: widget.folder?.color ?? Colors.blue,
                  onSaved: (color) {
                    _color = color;
                  },
                ),
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
                    initialValue: widget.folder?.title,
                    validator: (title) {
                      if (title == null || title.isEmpty) {
                        return 'Введите название папки';
                      }

                      return null;
                    },
                    onSaved: (title) {
                      _title = title;
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
                              final carcass = FolderCarcass(
                                title: _title!,
                                color: _color,
                              );
                              widget.onConfirm(carcass);
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
