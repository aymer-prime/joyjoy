// import 'package:fijkplayer/fijkplayer.dart';
// import 'package:flutter/material.dart';

// class VideoPlayer extends StatefulWidget {
//   final String url;
//   final bool autoPlay;
//   const VideoPlayer({super.key, required this.url, required this.autoPlay});

//   @override
//   State<VideoPlayer> createState() => _VideoPlayerState();
// }

// class _VideoPlayerState extends State<VideoPlayer> {
//    final FijkPlayer player = FijkPlayer();
//   @override
//   void initState() {
//     super.initState();
//     player.setDataSource(widget.url,
//         autoPlay: widget.autoPlay, showCover: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//       FijkView(
//       fit: FijkFit.cover,
//       fsFit: FijkFit.cover,
//       player: player,
//     );
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//    // player.release();
//   }
// }
