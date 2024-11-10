import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translate/buisness_logic_layer/cubit/translator_cubit.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key, required this.translateLanguage});
  final String? translateLanguage;

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _textController = TextEditingController();
  String translatedText = "";
  late TranslatorCubit translatorCubit;

  String fromLanguage = 'en';
  String toLanguage = '';

  @override
  void initState() {
    super.initState();
    translatorCubit = BlocProvider.of<TranslatorCubit>(context);
    toLanguage = widget.translateLanguage ?? 'tr';

    // Listen for changes in the text field and translate
    _textController.addListener(() {
      final inputText = _textController.text;
      if (inputText.isNotEmpty) {
        translatorCubit.getTranslatorText(inputText, fromLanguage, toLanguage);
      } else {
        setState(() {
          translatedText = "";
        });
      }
    });
  }

  void _swapLanguages() {
    setState(() {
      final temp = fromLanguage;
      fromLanguage = toLanguage;
      toLanguage = temp;

      // Trigger translation if there's text in the field
      if (_textController.text.isNotEmpty) {
        translatorCubit.getTranslatorText(
          _textController.text,
          fromLanguage,
          toLanguage,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fromLanguage.toUpperCase(),
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: _swapLanguages,
                    icon: const Icon(Icons.compare_arrows),
                    color: Colors.blue,
                    iconSize: 30,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    toLanguage.toUpperCase(),
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: "Write Here",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.white,
              ),
            ),
            const SizedBox(height: 150),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: BlocBuilder<TranslatorCubit, TranslatorState>(
                  builder: (context, state) {
                    if (state is TranslatorLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TranslationMaked) {
                      translatedText =
                          state.translation ?? "Translation failed";
                    } else if (state is TranslatorError) {
                      translatedText = "Error: ${state.message}";
                    }

                    return Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        translatedText,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
