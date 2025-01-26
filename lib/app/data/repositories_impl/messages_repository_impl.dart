import 'package:angry_customer_chatbot/app/core/generated/translations.g.dart';
import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/data/services/ia_service.dart';

import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';

import '../../domain/repositories/messages_repository.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  MessagesRepositoryImpl(this.iaService);

  final IAService iaService;

  @override
  AsyncResult<MessageModel> sendMessageAndReceiveAnswer({
    required String message,
    required List<MessageModel> oldMessages,
    required String responseInstructions,
    AppLocale locale = AppLocale.es,
  }) async {
    final oldMessagesText = oldMessages.isNotEmpty
        ? 'Please note the previous messages: ${oldMessages.map((e) {
            return e.isMe ? 'User: ${e.text}' : 'Bot: ${e.text}';
          }).join(', ')}'
        : '';
    final instructions =
        "$responseInstructions. Answer briefly and always in ${getLanguageString(locale)}.$oldMessagesText";
    return await iaService.sendMessageAndReceiveAnswer(
      message: message,
      responseInstructions: instructions,
    );
  }

  String getLanguageString(AppLocale locale) {
    switch (locale) {
      case AppLocale.en:
        return 'English';
      case AppLocale.es:
        return 'Spanish';
      case AppLocale.ca:
        return 'Catalan';
      default:
        return 'English';
    }
  }
}
