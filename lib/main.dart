import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arnuvapp/config/config.dart';
import 'package:arnuvapp/config/locale/locale_provider.dart';
import 'package:arnuvapp/config/locale/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  
  await Environment.initEnvironment();

  runApp(
    const ProviderScope(child: ArnuvApp())
  );
}

class ArnuvApp extends ConsumerWidget {
  const ArnuvApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final appRouter = ref.watch( goRouterProvider );
    final localestate = ref.watch(localeProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      locale: localestate.locale,
      supportedLocales: Environment.idiomasSoportados,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
    );
  }
}


class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return Environment.lenguajes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}