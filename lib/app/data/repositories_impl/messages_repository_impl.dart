import 'package:angry_customer_chatbot/app/core/generated/translations.g.dart';
import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/data/services/api_service.dart';

import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';
import 'package:angry_customer_chatbot/app/presentation/shared/utils.dart';

import '../../domain/repositories/messages_repository.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  MessagesRepositoryImpl(this.iaService);

  final ApiService iaService;

  @override
  AsyncResult<MessageModel> sendPromptAndReceiveAnswer({
    required String message,
    required List<MessageModel> oldMessages,
    required String responseInstructions,
    AppLocale locale = AppLocale.es,
    String? fileDataString,
  }) async {
    final oldMessagesText = oldMessages.isNotEmpty
        ? ' Please note the previous messages: ${oldMessages.map((e) {
            return e.isMe ? 'User: ${e.text}' : 'Bot: ${e.text}';
          }).join(', ')}.'
        : '';
    final fileDataText = fileDataString != null
        ? ' Please take into account the following information when answering: \'$fileDataString\'.'
        : '';
    final instructions =
        "$responseInstructions. Answer briefly and always in ${getStringFromLocale(locale)}.$fileDataText$oldMessagesText";
    return await iaService.sendPromptAndReceiveAnswer(
      message: message,
      responseInstructions: instructions,
    );
  }
}
