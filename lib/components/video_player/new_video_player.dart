import 'package:flutter/material.dart';
import 'package:story/story_page_view.dart';
import 'package:video_player/video_player.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';

class NewVideoPlayer extends StatefulWidget {
  const NewVideoPlayer({
    super.key,
    required this.url,
    required this.loadingNotifier,
  });
  final String url;
  final ValueNotifier<IndicatorAnimationCommand> loadingNotifier;

  @override
  State<NewVideoPlayer> createState() => _NewVideoPlayerState();
}

class _NewVideoPlayerState extends State<NewVideoPlayer> {
  late VideoPlayerController _controller;

  bool isLoading = true;

  Future<void> initPlayer() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    print(
        '3----------------------------- ${widget.loadingNotifier..value}');
    _controller.initialize().then((_) {
      setState(() {
        print(
        '4----------------------------- ${widget.loadingNotifier..value}');
        widget.loadingNotifier.value = IndicatorAnimationCommand.resume;
        isLoading = false;
        _controller.play();
      });
    });
  }

  @override
  void initState() {
    setState(() {
      widget.loadingNotifier.value = IndicatorAnimationCommand.pause;
    });
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
          )
        : VideoPlayer(_controller);
  }
}
