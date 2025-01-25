import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(false) bool fetching,
    @Default([]) List<MessageModel> messages,
  }) = _HomeState;
}
