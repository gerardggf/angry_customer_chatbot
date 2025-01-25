import 'package:angry_customer_chatbot/app/core/constants/urls.dart';
import 'package:angry_customer_chatbot/app/core/utils/failure/failure.dart';
import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/utils/either/either.dart';

final iaServiceProvider = Provider<IAService>(
  (ref) => IAService(
    ref.read(dioProvider),
  ),
);

class IAService {
  IAService(this.dio);

  final Dio dio;

  final String baseUrl = Urls.baseUrl;
  final String apiKey = dotenv.env['API_KEY'] ?? 'default_key';

  AsyncResult<MessageModel> sendMessageAndReceiveAnswer(
    String message,
  ) async {
    try {
      final response = await dio.post(
        '$baseUrl/v1/chat/completions',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: {
          'model': 'deepseek-chat',
          "messages": [
            {
              "role": "system",
              "content":
                  "You are an angry customer who has not received a food order yet..",
            },
            {
              "role": "user",
              "content": message,
            }
          ],
          "stream": false
        },
      );

      if (response.statusCode == 200) {
        return Either.right(
          MessageModel(
            text: response.data.toString(),
            isMe: false,
          ),
        );
      } else {
        return Either.left(
          Failure('Error'),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Either.left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
