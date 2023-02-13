/// A datclass for a video clip
class Language {
  const Language(
      {required this.id,
      required this.name,
      required this.icon,
      required this.code});

  final int id;
  final String name;
  final String icon;
  final String code;
}

class LanguageData {
  static const List<Language> data = [
    Language(id:0,name: 'Eng', icon:'assets/images/uk.jpeg', code: 'en'),
    Language(id:1,name: 'Greek', icon: 'assets/images/gr.png' ,code: 'gr'),
    Language(id:2,name: 'Turkish' , icon: 'assets/images/tr.png' ,code: 'tr'),
  ];

  LanguageData();
}
