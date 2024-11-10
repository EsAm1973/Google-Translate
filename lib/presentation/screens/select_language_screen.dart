import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  final Map<String, String> languageCodes = {
    'Arabic': 'ar',
    'German': 'de',
    'Russian': 'ru',
    'French': 'fr',
    'Spanish': 'es'
  };
  String? selectedLanguage;

  void _selectSpacificLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  void _navigateToTranslationScreen() {
    if (selectedLanguage != null) {
      final selectedCode = languageCodes[selectedLanguage]!;
      Navigator.pushNamed(context, 'translate',
          arguments: {'translateLanguage': selectedCode});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a language')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Select Language',
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: languageCodes.keys.length,
                    itemBuilder: (context, index) {
                      final language = languageCodes.keys.elementAt(index);
                      return AnimationConfiguration.staggeredList(
                          duration: const Duration(seconds: 1),
                          position: index,
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: GestureDetector(
                                onTap: () => _selectSpacificLanguage(language),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    elevation: 3,
                                    color: selectedLanguage == language
                                        ? Colors.grey.shade600
                                        : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Text(
                                          language,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color:
                                                  selectedLanguage == language
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))));
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _navigateToTranslationScreen,
                    child: const Text(
                      'Select Language',
                      style: TextStyle(fontSize: 24),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
