import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:story/story_page_view.dart';
import 'package:video_player/video_player.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';

class NewVideoPlayer extends StatefulWidget {
  final bool mute;
  const NewVideoPlayer({
    super.key,
    required this.url,
    this.mute = false,
  });
  final String url;

  @override
  State<NewVideoPlayer> createState() => _NewVideoPlayerState();
}

class _NewVideoPlayerState extends State<NewVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;

  bool isLoading = true;

  Future<void> initPlayer() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );

    _controller.initialize().then((_) {
      setState(() {
        isLoading = false;
        chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
          showControls: false,
        );
        if (widget.mute) {
          chewieController.setVolume(0);
        }
      });
    });
  }

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    chewieController.dispose();
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
        : Chewie(
            controller: chewieController,
          );
  }
}
