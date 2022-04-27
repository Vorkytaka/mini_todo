import 'package:flutter/material.dart';

Future<void> showNewTodoDialog({required BuildContext context}) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    builder: (context) {
      return const _NewTodoDialog();
    },
  );
}

class _NewTodoDialog extends StatelessWidget {
  const _NewTodoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Material(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Задача...',
                ),
                autofocus: true,
                textInputAction: TextInputAction.done,
                maxLines: null,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Wrap(
                      children: const [
                        _IconButton(
                          icon: Icon(Icons.today),
                        ),
                        SizedBox(width: 8),
                        _IconButton(
                          icon: Icon(Icons.inbox),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.send,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget icon;
  final Widget? text;
  final VoidCallback? onTap;

  const _IconButton({
    Key? key,
    required this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (text != null) ...[
              const SizedBox(width: 4),
              text!,
            ],
          ],
        ),
      ),
    );
  }
}
