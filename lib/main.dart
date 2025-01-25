import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/core/generated/translations.g.dart';
import 'app/core/providers.dart';
import 'app/accb_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    if (kDebugMode) {
      print('Error loading .env file: $e');
    }
  }
  runApp(
    ProviderScope(
      child: TranslationProvider(
        child: const AppStartupWidget(),
      ),
    ),
  );
}

final appStartupProvider = FutureProvider<void>(
  (ref) async {
    ref.onDispose(
      () {
        ref.invalidate(sharedPreferencesProvider);
        ref.invalidate(packageInfoProvider);
      },
    );
    await ref.watch(sharedPreferencesProvider.future);
    await ref.watch(packageInfoProvider.future);
  },
);
