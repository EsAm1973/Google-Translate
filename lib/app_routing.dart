import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translate/buisness_logic_layer/cubit/translator_cubit.dart';
import 'package:google_translate/data/api/translator_api.dart';
import 'package:google_translate/data/repository/tranlator_repository.dart';
import 'package:google_translate/presentation/screens/custom_splash_screen.dart';
import 'package:google_translate/presentation/screens/select_language_screen.dart';
import 'package:google_translate/presentation/screens/translation_screen.dart';

class AppRouting {
  Route? onGenereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const CustomSplashScreen(),
        );
      case 'select':
        return MaterialPageRoute(
          builder: (_) => const SelectLanguageScreen(),
        );
      case 'translate':
        final argument = settings.arguments as Map<String, String?>;
        final translateLanguage = argument['translateLanguage'];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TranslatorCubit>(
            create: (context) =>
                TranslatorCubit(TranlatorRepository(TranslatorApi())),
            child: TranslationScreen(
              translateLanguage: translateLanguage,
            ),
          ),
        );
      default:
        return null;
    }
  }
}
