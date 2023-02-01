/// A datclass for a video clip
class Language {
  const Language(this.id, this.name);

  final int id;
  final String name;
}

class LanguageData {
  static const List<Language> data = [
    Language(0, 'Eng'),
    Language(1, 'Greek'),
    Language(2, 'Turkish'),
  ];

  LanguageData();
}
