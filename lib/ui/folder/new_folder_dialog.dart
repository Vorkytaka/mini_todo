import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/folder_repository.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/common/color_picker.dart';

import '../../constants.dart';
import '../../entity/folder.dart';

Future<void> showNewFolderDialog({required BuildContext context}) => showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => _EditableFolderDialog(
        onConfirm: (folder) async {
          await context.read<FolderRepository>().create(folder);
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
      builder: (context) => _EditableFolderDialog(
        folder: folder,
        onConfirm: (carcass) async {
          final newFolder = Folder(
            id: folder.id,
            title: carcass.title,
            color: carcass.color,
          );
          await context.read<FolderRepository>().update(newFolder);
          Navigator.of(context).pop();
        },
      ),
    );

typedef _OnConfirm = void Function(FolderCarcass carcass);

class _EditableFolderDialog extends StatefulWidget {
  final Folder? folder;
  final _OnConfirm onConfirm;

  const _EditableFolderDialog({
    Key? key,
    this.folder,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<_EditableFolderDialog> createState() => _EditableFolderDialogState();
}

class _EditableFolderDialogState extends State<_EditableFolderDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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
        borderRadius: borderRadiusMedium,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).editable_folder_dialog__hint,
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
                        return S.of(context).editable_folder_dialog__title_error;
                      }

                      return null;
                    },
                    onSaved: (title) {
                      _title = title;
                    },
                    onFieldSubmitted: (str) {
                      _submit();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _submit,
                  icon: const Icon(Icons.done),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      final carcass = FolderCarcass(
        title: _title!,
        color: _color,
      );
      widget.onConfirm(carcass);
    }
  }
}
