import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dialogs {
  Dialogs._();

  static Future<bool> trueFalse({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    final result = await showDialog<bool?>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.pop(true);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
