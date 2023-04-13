import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:consent_app/src/video_player_feature/video_item_dataclass.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../components/explainerAssetVideo.dart';
import '../components/frame.dart';

class VideoItemDetailsView extends StatefulWidget {
  // In the constructor, require a videoId.
  VideoItemDetailsView({super.key, required this.videoId});

  // Declare a field that holds the videoId.
  final int videoId;
  static const routeName = '/detail';

  @override
  State<VideoItemDetailsView> createState() => _VideoItemDetailsViewState();
}

class _VideoItemDetailsViewState extends State<VideoItemDetailsView>
    with RouteAware {
  Store store = locator<Store>();

  late VideoItem item;

  late VideoPlayerController videoController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    videoController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print('didPush');
  }

  @override
  void didPushNext() {
    // Route was pushed onto navigator and is now topmost route.
    print('did PushNext');
    this.videoController.dispose();
  }

  @override
  void didPop() {
    // Route was pushed onto navigator and is now topmost route.
    print('did pop');
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print('did PopNext');
  }

  @override
  Widget build(BuildContext context) {
    // Use the videoId to create the UI.
    Store store = locator<Store>();
    VideoItem item =
        store.procedure.videos.firstWhere((item) => item.id == widget.videoId);
    store.videoItem = item;
    this.videoController = VideoPlayerController.asset(item.path);
    Orientation orientation = MediaQuery.of(context).orientation;
    double footerPadding = (orientation == Orientation.portrait  ? 10.0 : 0.0);
    return FrameView(
        heading: '${item.heading}'.i18n,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ExplainerAssetVideo(
                  key: Key(item.id.toString()),
                  path: item.path,
                  item: item,
                  controller: videoController,
                ),
              ),
            ),
            Expanded(
              flex: orientation == Orientation.portrait ? 1 : 0,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding:  EdgeInsets.all(footerPadding),

              ),
            ),
          ],
        ));
  }
}
