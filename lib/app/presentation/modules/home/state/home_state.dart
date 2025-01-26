import 'package:angry_customer_chatbot/app/core/constants/global.dart';
import 'package:angry_customer_chatbot/app/core/generated/translations.g.dart';
import 'package:angry_customer_chatbot/app/domain/models/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(false) bool fetching,
    @Default([]) List<MessageModel> messages,
    @Default(Global.responseInstructions) String responseInstructions,
    @Default(AppLocale.es) AppLocale responseLocale,
  }) = _HomeState;
}
