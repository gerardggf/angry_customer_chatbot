import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/generated/translations.g.dart';

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

  static Future<AppLocale?> localeModalBottomSheet({
    required BuildContext context,
  }) async {
    final result = await showModalBottomSheet<AppLocale?>(
      context: context,
      builder: (_) => Column(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () => context.pop(AppLocale.en),
          ),
          ListTile(
            title: const Text('Spanish'),
            onTap: () => context.pop(AppLocale.es),
          ),
          ListTile(
            title: const Text('Catalan'),
            onTap: () => context.pop(AppLocale.ca),
          ),
        ],
      ),
    );
    return result;
  }
}
