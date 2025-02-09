import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/data/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/generated/translations.g.dart';
import '../../data/repositories_impl/messages_repository_impl.dart';
import '../models/message_model.dart';

final messagesRepoProvider = Provider<MessagesRepository>(
  (ref) => MessagesRepositoryImpl(
    ref.read(apiServiceProvider),
  ),
);

abstract class MessagesRepository {
  AsyncResult<MessageModel> sendPromptAndReceiveAnswer({
    required String message,
    required List<MessageModel> oldMessages,
    required String responseInstructions,
    String? fileDataString,
    AppLocale locale = AppLocale.es,
  });
}
