/// A datclass for a video clip
class Language {
  const Language(this.id, this.name, this.code);

  final int id;
  final String name;
  final String code;
}

class LanguageData {
  static const List<Language> data = [
    Language(0, 'Eng', 'en'),
    Language(1, 'Greek', 'gr'),
    Language(2, 'Turkish', 'tr'),
  ];

  LanguageData();
}
