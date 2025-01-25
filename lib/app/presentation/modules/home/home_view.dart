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
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            reverse: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[state.messages.length - 1 - index];
              return Align(
                alignment:
                    message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: message.isMe
                        ? Colors.teal.shade100
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(8),
                      topRight: const Radius.circular(8),
                      bottomLeft:
                          message.isMe ? const Radius.circular(8) : Radius.zero,
                      bottomRight:
                          message.isMe ? Radius.zero : const Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          )),
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
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
