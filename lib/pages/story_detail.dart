//import 'package:tryt/components/video_player.dart';
import 'package:tryt/components/video_player/new_video_player.dart';
import 'package:tryt/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:story/story_page_view.dart';
import 'package:video_player/video_player.dart';

class StoryDetail extends StatefulWidget {
  final List<Storymodel> storyList;
  final int storyPage;
  const StoryDetail(
      {super.key, required this.storyList, required this.storyPage});

  @override
  State<StoryDetail> createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  List<Storymodel> storyList = [];
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  @override
  void initState() {
    super.initState();
    storyList = widget.storyList;
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.pause);
    print(
        '1----------------------------- ${indicatorAnimationController.value}');
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        '2----------------------------- ${indicatorAnimationController.value}');
    return Scaffold(
      body: SafeArea(
        child: StoryPageView(
          indicatorAnimationController: indicatorAnimationController,
          initialPage: widget.storyPage,
          indicatorDuration: const Duration(seconds: 15),
          itemBuilder: (context, pageIndex, storyIndex) {
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                      (storyList[pageIndex].stories![storyIndex].type == "mp4")
                          ? NewVideoPlayer(
                              loadingNotifier: indicatorAnimationController,
                              url: storyList[pageIndex]
                                  .stories![storyIndex]
                                  .src
                                  .toString(),
                            )
                          // VideoPlayer(
                          //     url: storyList[pageIndex]
                          //         .stories![storyIndex]
                          //         .src
                          //         .toString(),
                          //     autoPlay: true,
                          //   )
                          : Image.network(
                              storyList[pageIndex]
                                  .stories![storyIndex]
                                  .src
                                  .toString(),
                              fit: BoxFit.cover,
                            ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  top: 32,
                  child: SizedBox(
                    height: 64,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            storyList[pageIndex].model!.img!,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(storyList[pageIndex].model!.name!),
                        const Expanded(
                          child: Text(""),
                        ),
                        Text(storyList[pageIndex].stories![storyIndex].date!)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          storyLength: (pageIndex) {
            return storyList[pageIndex].stories!.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
          pageLength: storyList.length,
        ),
      ),
    );
  }
}
