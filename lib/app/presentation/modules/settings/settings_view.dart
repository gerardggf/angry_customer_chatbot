import 'package:angry_customer_chatbot/app/core/constants/global.dart';
import 'package:angry_customer_chatbot/app/core/generated/translations.g.dart';
import 'package:angry_customer_chatbot/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:angry_customer_chatbot/app/presentation/shared/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/utils.dart';
import '../home/home_controller.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  static const String routeName = 'settings';

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final _roleController = TextEditingController(),
      _localeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _roleController.text = Global.responseInstructions;
    _localeController.text = mapStringFromLocale(AppLocale.es);
  }

  @override
  void dispose() {
    _roleController.dispose();
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(homeControllerProvider);
    final notifier = ref.read(homeControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _roleController,
              decoration: const InputDecoration(
                hintText: '...',
                labelText: 'Chatbot role',
              ),
            ),
            20.h,
            GestureDetector(
              onTap: () async {
                final locale =
                    await Dialogs.localeModalBottomSheet(context: context);
                if (locale == null) return;
                _localeController.text = mapStringFromLocale(locale);
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _localeController,
                  decoration: const InputDecoration(
                    hintText: '...',
                    labelText: 'Response language',
                  ),
                ),
              ),
            ),
            20.h,
            ElevatedButton(
              onPressed: () {
                notifier.updateResponseLanguage(
                    mapLocaleFromString(_localeController.text));
                notifier.updateResponseInstructions(_roleController.text);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
