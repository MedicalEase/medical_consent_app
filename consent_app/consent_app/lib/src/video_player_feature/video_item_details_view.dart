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

  VideoItem? item;
  Orientation orientation = Orientation.landscape;
  double footerPadding = 0.0;

  VideoPlayerController? videoController = null;

  @override
  initState() {
    super.initState();
    print('initState  18');
    Store store = locator<Store>();
    print('summary: ${store.summary}');
    store.videoItem =
        store.procedure.videos.firstWhere((itm) => itm.id == widget.videoId);
    videoController = VideoPlayerController.asset(store.videoItem.getFullPath());
  }

  @override
  void deactivate() {
    print('32 deactivate');
    super.deactivate();
  }

  @override
  didChangeDependencies() {
    orientation = MediaQuery.of(context).orientation;
    footerPadding = (orientation == Orientation.portrait ? 10.0 : 0.0);
    print('didChangeDependencies  35');
    // if (this.videoController != null) {
    //   print('vid controller not null  35');
    //   this.videoController?.pause();
    //   this.videoController?.dispose();
    // }
    // print('didChangeDependencies  37');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant VideoItemDetailsView oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget  39');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('39 dispose');
    routeObserver.unsubscribe(this);
    if (this.videoController != null) {
      this.videoController?.pause();
      this.videoController?.dispose();
    }
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
    print('72 playing video ${widget.videoId}  ${widget.key}');
    var item   = this.store.videoItem;
    // Use the videoId to create the UI.
    return FrameView(
        heading: '${this.store.videoItem == null ?  Placeholder() : this.store.videoItem.heading}'.i18n,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: item == null
                    ? Placeholder()
                    : ExplainerAssetVideo(
                        key: Key(item!.id.toString()),
                        path: item!.getFullPath(),
                        item: item!,
                        controller: videoController,
                      ),
              ),
            ),
            Expanded(
              flex: orientation == Orientation.portrait ? 1 : 0,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.all(footerPadding),
              ),
            ),
          ],
        ));
  }
}
