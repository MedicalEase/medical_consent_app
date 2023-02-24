import 'package:consent_app/src/components/frame.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.dart';
import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/summary_feature/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import '../video_player_feature/video_item_dataclass.dart';
import '../video_player_feature/video_item_details_view.dart';
import '../video_player_feature/video_item_list_view.dart';

class OrientationSwitcher extends StatelessWidget {
  final List<Widget> children;

  const OrientationSwitcher({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Column(children: children)
        : Row(children: children);
  }
}

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  static const routeName = '/intro';

  @override
  Widget build(BuildContext context) {
    Store store = locator<Store>();
    Orientation orientation = MediaQuery.of(context).orientation;
    List<VideoItem> items = store.procedures[0].videos;
    var procedure = store.procedures[0];
    VideoItem item = items.firstWhere((item) => item.id == 1);
    var videoController = VideoPlayerController.asset(item.path);

    return FrameView(
        heading: 'Intro',
        body: Center(
            child: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    " Be unprepared.All children like breaked lentils\n in rice "
                    "vinegar and black cardamon. "
                    "Be unprepared.All children \n like breaked lentils in "
                    "rice "
                    "vinegar and black cardamon. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              Image.asset('assets/images/colonscopy_icon.png'),

              //               ExplainerAssetVideo(
              //   key: Key(item.id.toString()),
              //   path: item.path,
              //   item: item,
              //   controller: videoController,
              // ),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: ElevatedButton(
                              child: Text(
                                'Approve',
                                style: TextStyle(fontSize: 64),
                              ),
                              onPressed: () {
                                Navigator.restorablePushNamed(
                                  context,
                                  ProcedureListView.routeName,
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: ElevatedButton(
                              child: Text(
                                'Approve fiery',
                                style: TextStyle(fontSize: 64),
                              ),
                              onPressed: () => null,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: ElevatedButton(
                              child: Text(
                                'Issue Stormy, doubloons.',
                                style: TextStyle(fontSize: 64),
                              ),
                              onPressed: () => null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        )));
  }
}

// Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.fitHeight,
//               image: NetworkImage("https://picsum.photos/250?image=9"),
//             ),
//           ),
//         )
