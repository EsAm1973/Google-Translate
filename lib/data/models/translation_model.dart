class Translation {
  final String translationText;

  Translation({required this.translationText});

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      translationText: json['data']['translations'][0]['translatedText'],
    );
  }
}
