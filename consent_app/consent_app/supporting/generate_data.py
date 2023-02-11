import csv
from collections import defaultdict
from dataclasses import dataclass, field


@dataclass
class SubtitleLine:
    videoId: int
    start: int
    end: int
    text: str

    def __repr__(self):
        return generate_subtitle_item(self)


@dataclass
class VideoItem:
    id: int
    path: str
    procedure: str
    heading: str
    summary: str
    questionAfter: int
    subtitles: list[SubtitleLine] = field(default_factory=list)

    def __repr__(self):
        return generate_video_item(self)


@dataclass
class Procedure:
    id: int
    name: str
    videos: list[VideoItem] = field(default_factory=list)


def generate_video_item(data: VideoItem):
    return f"""VideoItem(
  id: {data.id},
  path: '{data.path}',
  heading: '{data.heading}',
  summary: '{data.summary}',
  questionAfter: {data.questionAfter},
  subtitles: {data.subtitles},)
 """


def generate_subtitle_item(data: SubtitleLine):
    return f"""SubtitleLine('{data.text}', Duration(seconds: {data.start}), Duration(seconds: {data.end})"""


procedures = {row['id']: Procedure(**row) for row in (csv.DictReader(open('ConsentAppDatanumbers/procedures-Table 1.csv', 'r')))}

videos = {}
for row in (csv.DictReader(open('ConsentAppDatanumbers/videos-Video clips.csv', 'r'))):
    videos[row['id']] = VideoItem(**row)

subtitles = [(row['videoId'], SubtitleLine(**row)) for row in (csv.DictReader(open('ConsentAppDatanumbers/subtitles-Subtitles.csv', 'r')))]

for key, value in subtitles:
    videos[key].subtitles.append(value)

for video in videos.values():
    procedures[video.procedure].videos.append(video)

for procedure in procedures.values():
    print(procedure)