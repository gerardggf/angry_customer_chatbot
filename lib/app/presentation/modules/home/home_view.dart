import 'package:angry_customer_chatbot/app/core/utils/extensions/num_to_sizedbox.dart';
import 'package:angry_customer_chatbot/app/core/utils/extensions/theme_mode_extension.dart';
import 'package:angry_customer_chatbot/app/presentation/modules/home/widgets/message_bubble_widget.dart';
import 'package:angry_customer_chatbot/app/presentation/modules/settings/settings_view.dart';
import 'package:angry_customer_chatbot/app/presentation/shared/controllers/theme_controller.dart';
import 'package:angry_customer_chatbot/app/presentation/shared/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'home_controller.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routeName = 'home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {},
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);
    final notifier = ref.read(homeControllerProvider.notifier);
    ref.listen(
      homeControllerProvider,
      (previous, next) {
        if (previous == null) return;
        if (next.responseInstructions != previous.responseInstructions) {
          Dialogs.snackBar(context: context, text: 'Chatbot role changed');
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(themeControllerProvider.notifier)
                  .updateTheme(!context.isDarkMode);
            },
            icon: Icon(
              context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: () {
              context.pushNamed(SettingsView.routeName);
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
          IconButton(
            onPressed: () async {
              final doIt = await Dialogs.trueFalse(
                context: context,
                title: 'Are you sure?',
                content: 'All messages will be deleted',
              );
              if (!doIt) return;
              notifier.clearMessages();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
          20.w,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message =
                    state.messages[state.messages.length - 1 - index];
                return MessageBubbleWidget(
                  message: message,
                );
              },
            ),
          ),
          if (state.fetching)
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.black12,
            child: Row(
              children: [
                Expanded(
                  child: KeyboardListener(
                    onKeyEvent: (value) {
                      if (value.logicalKey == LogicalKeyboardKey.enter) {
                        if (_textController.text.isNotEmpty) {
                          notifier.sendMessage(_textController.text);
                          _textController.clear();
                        }
                      }
                    },
                    focusNode: _focusNode,
                    child: TextField(
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Write a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      notifier.sendMessage(_textController.text);
                      _textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
