part of 'translator_cubit.dart';

@immutable
sealed class TranslatorState {}

class TranslatorInitial extends TranslatorState {}

class TranslatorLoading extends TranslatorState {}

class TranslationMaked extends TranslatorState {
  final String? translation;

  TranslationMaked({required this.translation});
}

class TranslatorError extends TranslatorState {
  final String message;

  TranslatorError(this.message);
}
