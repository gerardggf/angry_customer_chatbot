import 'package:angry_customer_chatbot/app/presentation/modules/home/widgets/message_bubble_widget.dart';
import 'package:angry_customer_chatbot/app/presentation/shared/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_controller.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routeName = 'home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);
    final notifier = ref.read(homeControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
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
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: true,
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: InputBorder.none,
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
