import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/data/services/ia_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories_impl/messages_repository_impl.dart';
import '../models/message_model.dart';

final messagesRepoProvider = Provider<MessagesRepository>(
  (ref) => MessagesRepositoryImpl(
    ref.read(iaServiceProvider),
  ),
);

abstract class MessagesRepository {
  AsyncResult<MessageModel> sendMessageAndReceiveAnswer(String message);
}
