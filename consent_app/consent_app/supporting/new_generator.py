import csv
from dataclasses import dataclass, field


@dataclass
class PatientButton:
    text: str
    icon: str
    textcolour: str
    backcolour: str
    link: str = ''
    video_sequence_link: str = ''
    custom_code: str = ''

    def __post_init__(self):
        self.icon = self.icon.replace('⏪', 'fast_rewind').lower()
        self.icon = self.icon.replace('️️️➡️', 'fast_forward').lower()
        self.icon = self.icon.replace('✅', 'done').lower()
        self.icon = self.icon.replace('❌', 'close').lower()
        self.icon = self.icon.replace('❓', 'help_outline').lower()
        self.icon = self.icon.replace('⏱️', 'flaky').lower()
        if 'next' in self.icon:
                print(self.icon)
        self.icon = self.icon.replace('next_patient', 'restart_alt').lower()

        self.custom_code = f'locator<Store>().summary.{self.custom_code.strip()};' if self.custom_code.strip() else ''

    def __repr__(self):
        return f"""
        PatientButton(
            text: '{self.text}',
            icon:  Icons.{self.icon},
            backColor: Colors.{self.backcolour},
            textColor: Colors.{self.textcolour},
            function: (BuildContext context) {{
                {self.custom_code}
                Navigator.pushReplacementNamed(
                context,
                VideoItemDetailsView.routeName,
                arguments: {self.link},
              );
            }})"""


@dataclass
class VideoItem:
    video_id: int
    path: str
    realpath: str
    function: str
    display_icon: str
    appearance_time_gr: str
    appear_from_the_end_tk: str
    icon_colour: str
    backcolour: str
    video_sequence_link: str
    link: str
    custom_code: str
    questionBank: list[PatientButton] = field(default_factory=list)
    header: str = ''
    question_after: int = 3

    def get_questionBank(self):
        return ','.join(i.__repr__() for i in self.questionBank)

    def __post_init__(self):
        texts = self.function.split(' ')
        icons = self.display_icon.split(' ')
        self.question_after = self.calculate_question_after()
        textColours = self.icon_colour.lower().split(' ')
        backColours = self.backcolour.lower().split(' ')
        video_sequence_link = self.video_sequence_link.split(' ')
        links = self.link.split(' ') if self.link else ['']
        custom_code = self.custom_code if self.custom_code else ';' * len(texts)
        custom_code = custom_code.split(';') + [''] * len(texts)
        for data in zip(texts, icons, textColours, backColours, links, video_sequence_link, custom_code,):
            self.questionBank.append(PatientButton(*data))

    def calculate_question_after(self):
        # appearance_time_gr is like ' End -5'
        s = self.appearance_time_gr
        return int(s.split()[1])

    def __repr__(self):
        return f"""VideoItem(
              id: {self.video_id},
              path: '{self.path.upper().replace(' ','_')}.mp4',
              heading: '{self.header}',
              questionAfter: {self.question_after},
              subtitles: [],
              questionBank: {self.questionBank}
              ),
              """


def lowercase_with_dashes_keys(row: dict):
    r = {}
    for key in row.keys():
        r[key.lower().replace(' ', '_').replace('/','_')] = row[key]
    return r


for row in (csv.DictReader(open('medical consent app.csv', 'r', encoding='utf-8-sig'))):
    row = lowercase_with_dashes_keys(row)
    button = VideoItem(**row)
    print(button)
    print(button, file=open('output.dart', 'a'))


