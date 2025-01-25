import 'package:angry_customer_chatbot/app/core/constants/urls.dart';
import 'package:angry_customer_chatbot/app/core/utils/failure/failure.dart';
import 'package:angry_customer_chatbot/app/core/utils/typedefs.dart';
import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/api_key.dart';
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

  final String url = Urls.promptEndpoint;
  // final String apiKey = dotenv.env['API_KEY'] ?? 'default_key';
  final String apiKey =
      kApiKey; //API_KEY oculta. en proceso de pasarla a un .env

  AsyncResult<MessageModel> sendMessageAndReceiveAnswer({
    required String message,
    required String responseInstructions,
  }) async {
    try {
      if (kDebugMode) {
        print(responseInstructions);
      }
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: {
          'model': 'llama-3.3-70b-versatile',
          "messages": [
            {
              "role": "system",
              "content": responseInstructions,
            },
            {
              "role": "user",
              "content": message,
            }
          ],
        },
      );

      if (response.statusCode == 200) {
        return Either.right(
          MessageModel(
            text: response.data['choices'][0]['message']['content'],
            isMe: false,
          ),
        );
      } else {
        return Either.left(
          Failure('Status code: ${response.statusCode}'),
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
