import 'package:angry_customer_chatbot/app/core/generated/translations.g.dart';

AppLocale mapLocaleFromString(String localeString) {
  switch (localeString) {
    case "English":
      return AppLocale.en;
    case "Español":
      return AppLocale.es;
    case "Català":
      return AppLocale.ca;
    default:
      return AppLocale.en;
  }
}

String mapStringFromLocale(AppLocale locale) {
  switch (locale) {
    case AppLocale.en:
      return "English";
    case AppLocale.es:
      return "Español";
    case AppLocale.ca:
      return "Català";
    default:
      return "English";
  }
}
