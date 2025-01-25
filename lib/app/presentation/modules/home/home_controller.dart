import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';
import 'package:angry_customer_chatbot/app/domain/repositories/messages_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/home_state.dart';

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController(
    HomeState(),
    ref.read(messagesRepoProvider),
  ),
);

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state,
    this.messagesRepository,
  );

  final MessagesRepository messagesRepository;

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  void addMessage({
    required String message,
    required bool isMe,
    bool isError = false,
  }) {
    state = state.copyWith(
      messages: List.from(state.messages)
        ..add(
          MessageModel(
            text: message,
            isMe: isMe,
            isError: isError,
          ),
        ),
    );
  }

  AsyncResult<MessageModel> sendMessage(String message) async {
    updateFetching(true);

    addMessage(message: message, isMe: true);
    final result =
        await messagesRepository.sendMessageAndReceiveAnswer(message);
    result.when(
      left: (failure) {
        addMessage(
          message: failure.message,
          isMe: false,
          isError: true,
        );
      },
      right: (message) {
        print(message.text);
        addMessage(
          message: message.text,
          isMe: false,
        );
      },
    );
    updateFetching(false);
    return result;
  }
}
