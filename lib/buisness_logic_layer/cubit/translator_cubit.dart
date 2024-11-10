import 'package:bloc/bloc.dart';
import 'package:google_translate/data/repository/tranlator_repository.dart';
import 'package:meta/meta.dart';

part 'translator_state.dart';

class TranslatorCubit extends Cubit<TranslatorState> {
  final TranlatorRepository tranlatorRepository;

  TranslatorCubit(this.tranlatorRepository) : super(TranslatorInitial());

  Future<void> getTranslatorText(
      String text, String fromLanguage, String toLanguage) async {
    try {
      emit(TranslatorLoading());
      final translationText = await tranlatorRepository.translateText(
          text, fromLanguage, toLanguage);

      if (translationText != null) {
        emit(TranslationMaked(translation: translationText));
      } else {
        emit(TranslatorError(
            'Translation failed: Unable to retrieve translation'));
      }
    } catch (e) {
      print('Error during translation: $e');
      emit(TranslatorError('Error when translating text: ${e.toString()}'));
    }
  }
}
