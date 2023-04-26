import csv
from collections import defaultdict

from dataclasses import dataclass, field

'''
Procedure(id: 0, name: 'OGD', icon: 'assets/images/ogd_icon.png', videos: [
  VideoItem(
      id: 0,
      path: 'assets/video/1-2-intro.mp4',
      heading: '0 Risks and benefits',
      questionAfter: 2,
      questionBank: [
        PatientButton(
            text: 'Yes',
            backColor: Colors.green,
            function: (BuildContext context) {
              developer.log('yes');
              Navigator.pushReplacementNamed(
                context,
                VideoItemDetailsView.routeName,
                arguments: 1,
              );
            }),
'''
def generate_button_item(self):
    return f"""PatientButton(
text: '{self.text}',
backColor: Colors.{self.backColor},
textColor: Colors.{self.textColor},
function: (BuildContext context) {{
    developer.log('{self.text}');
  Navigator.pushReplacementNamed(
    context,
    VideoItemDetailsView.routeName,
    arguments: {self.nextVideo},
  );
}})"""


@dataclass
class PatientButton:
    videoid: str
    text: str
    backColor: str
    textColor: str
    nextVideo: int = 0
    def __repr__(self):
        return generate_button_item(self)


@dataclass
class VideoItem:
    id: int
    path: str
    procedure: str
    heading: str
    questionAfter: int
    questionBank: list[PatientButton] = field(default_factory=list)

    def __repr__(self):
        return generate_video_item(self)


@dataclass
class Procedure:
    id: int
    name: str
    icon: str = 'xx'
    videos: list[VideoItem] = field(default_factory=list)


def generate_video_item(data: VideoItem):
    return f"""VideoItem(
  id: {data.id},
  path: '{data.path}',
  heading: '{data.heading}',
  questionAfter: {data.questionAfter},
  questionBank: {data.questionBank},
 """




procedures = {row['id']: Procedure(**row) for row in (csv.DictReader(open('ConsentAppDatanumbers/procedures-Table 1.csv', 'r')))}

videos = {}
for row in (csv.DictReader(open('ConsentAppDatanumbers/videos-Video clips.csv', 'r'))):
    videos[row['id']] = VideoItem(**row)
buttons = defaultdict(list)
for row in (csv.DictReader(open('ConsentAppDatanumbers/videos-patientbuttons.csv', 'r'))):
    buttons[row['videoid']].append(PatientButton(**row))

for key in buttons:
    videos[key].questionBank= buttons[key]

for video in videos.values():
    procedures[video.procedure].videos.append(video)

for procedure in procedures.values():
    print(procedure)
