import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/data/services/ia_service.dart';

import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';

import '../../domain/repositories/messages_repository.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  MessagesRepositoryImpl(this.iaService);

  final IAService iaService;

  @override
  AsyncResult<MessageModel> sendMessageAndReceiveAnswer(String message) async {
    return await iaService.sendMessageAndReceiveAnswer(message);
  }
}
