//import 'package:tryt/components/video_player.dart';
import 'package:story_view/story_view.dart';
import 'package:tryt/components/video_player/new_video_player.dart';
import 'package:tryt/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:story/story_page_view.dart';
import 'package:video_player/video_player.dart';

class NewStoryDetail extends StatefulWidget {
  final List<Storymodel> storyList;
  final int storyPage;
  const NewStoryDetail(
      {super.key, required this.storyList, required this.storyPage});

  @override
  State<NewStoryDetail> createState() => _NewStoryDetailState();
}

class _NewStoryDetailState extends State<NewStoryDetail> {
  final StoryController controller = StoryController();
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.storyPage);
    currentPage = widget.storyPage;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
            itemCount: widget.storyList.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  StoryView(
                    controller: controller,
                    storyItems: widget.storyList[index].stories!.map(
                      (e) {
                        if (e.type == "mp4") {
                          return StoryItem.pageVideo(
                            e.src!,
                            controller: controller,
                            imageFit: BoxFit.cover,
                          );
                        } else {
                          return StoryItem.pageImage(
                            url: e.src!,
                            controller: controller,
                            imageFit: BoxFit.cover,
                            duration: const Duration(seconds: 10),
                          );
                        }
                      },
                    ).toList(),
                    onStoryShow: (storyItem, index) {
                      print("Showing a story");
                    },
                    onComplete: () {
                      print("Completed a cycle");
                      if (index + 1 == widget.storyList.length) {
                        Navigator.of(context).pop();
                      } else {
                        pageController.animateToPage(
                          index + 1,
                          duration: Durations.medium1,
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    inline: false,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: SizedBox(
                      height: 64,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              widget.storyList[index].model!.img!,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.storyList[index].model!.name!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),

        // StoryPageView(
        //   indicatorAnimationController: indicatorAnimationController,
        //   initialPage: widget.storyPage,
        //   indicatorDuration: const Duration(seconds: 15),
        //   itemBuilder: (context, pageIndex, storyIndex) {
        //     return Stack(
        //       children: [
        //         SizedBox(
        //           width: MediaQuery.of(context).size.width,
        //           height: MediaQuery.of(context).size.height,
        //           child:
        //               (storyList[pageIndex].stories![storyIndex].type == "mp4")
        //                   ? NewVideoPlayer(
        //                       loadingNotifier: indicatorAnimationController,
        //                       url: storyList[pageIndex]
        //                           .stories![storyIndex]
        //                           .src
        //                           .toString(),
        //                     )
        //                   // VideoPlayer(
        //                   //     url: storyList[pageIndex]
        //                   //         .stories![storyIndex]
        //                   //         .src
        //                   //         .toString(),
        //                   //     autoPlay: true,
        //                   //   )
        //                   : Image.network(
        //                       storyList[pageIndex]
        //                           .stories![storyIndex]
        //                           .src
        //                           .toString(),
        //                       fit: BoxFit.cover,
        //                     ),
        //         ),
        //         Positioned(
        //           left: 12,
        //           right: 12,
        //           top: 32,
        //           child: SizedBox(
        //             height: 64,
        //             width: MediaQuery.of(context).size.width,
        //             child: Row(
        //               children: [
        //                 CircleAvatar(
        //                   radius: 16,
        //                   backgroundImage: NetworkImage(
        //                     storyList[pageIndex].model!.img!,
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   width: 8,
        //                 ),
        //                 Text(storyList[pageIndex].model!.name!),
        //                 const Expanded(
        //                   child: Text(""),
        //                 ),
        //                 Text(storyList[pageIndex].stories![storyIndex].date!)
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        //   storyLength: (pageIndex) {
        //     return storyList[pageIndex].stories!.length;
        //   },
        //   onPageLimitReached: () {
        //     Navigator.pop(context);
        //   },
        //   pageLength: storyList.length,
        // ),
      ),
    );
  }
}
