import 'dart:convert';
import 'dart:io';

import 'package:angry_customer_chatbot/app/core/constants/global.dart';
import 'package:angry_customer_chatbot/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:angry_customer_chatbot/app/presentation/shared/dialogs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final state = ref.read(homeControllerProvider);
        _localeController.text = getStringFromLocale(state.responseLocale);
        _roleController.text = state.responseInstructions.isEmpty
            ? Global.responseInstructions
            : state.responseInstructions;
      },
    );
  }

  @override
  void dispose() {
    _roleController.dispose();
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);
    final notifier = ref.read(homeControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              notifier.updateResponseLanguage(
                  getLocaleFromString(_localeController.text));
              notifier.updateResponseInstructions(_roleController.text);
              context.pop();
            },
            icon: const Icon(
              Icons.save,
              size: 30,
            ),
          ),
          10.w,
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _roleController,
              decoration: const InputDecoration(
                hintText: '...',
                labelText: 'Chatbot role',
              ),
              maxLines: 3,
            ),
            30.h,
            GestureDetector(
              onTap: () async {
                final locale =
                    await Dialogs.localeModalBottomSheet(context: context);
                if (locale == null) return;
                _localeController.text = getStringFromLocale(locale);
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
            30.h,
            Text(
              'Attach file (${Global.allowedFileExtensions.map((e) => '.$e').join(', ')})',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            10.h,
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.file_copy),
                  onPressed: () async {
                    final filePickerResult =
                        await FilePicker.platform.pickFiles(
                      allowedExtensions: Global.allowedFileExtensions,
                      type: FileType.custom,
                      withData: true,
                    );
                    if (filePickerResult == null) return;
                    final file = filePickerResult.files.single;
                    String? result;
                    if (kIsWeb) {
                      if (file.bytes == null) return;
                      result = utf8.decode(file.bytes!);
                    } else {
                      if (file.path == null) return;
                      result = await File(file.path!).readAsString();
                    }
                    notifier.updateFileDataString(result);
                  },
                  label: Text(
                    state.fileDataString != null &&
                            state.fileDataString!.isNotEmpty
                        ? 'Replace document'
                        : 'Select a document',
                  ),
                ),
                10.w,
                if (state.fileDataString != null &&
                    state.fileDataString!.isNotEmpty)
                  IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 30,
                    ),
                    onPressed: () {
                      notifier.updateFileDataString(null);
                    },
                  ),
              ],
            ),
            10.h,
            Text(state.fileDataString ?? ''),
          ],
        ),
      ),
    );
  }
}
