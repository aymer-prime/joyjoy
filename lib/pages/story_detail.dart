import 'package:tryt/components/video_player.dart';
import 'package:tryt/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:story/story_page_view.dart';

class StoryDetail extends StatefulWidget {
  final List<Storymodel> stoyrlist;
  final int storyPage;
  const StoryDetail(
      {super.key, required this.stoyrlist, required this.storyPage});

  @override
  State<StoryDetail> createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  List<Storymodel> stoyrlist = [];
  @override
  void initState() {
    super.initState();
    stoyrlist = widget.stoyrlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StoryPageView(
          initialPage: widget.storyPage,
          indicatorDuration: const Duration(seconds: 15),
          itemBuilder: (context, pageIndex, storyIndex) {
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                      (stoyrlist[pageIndex].stories![storyIndex].type == "mp4")
                          ? VideoPlayer(
                              url: stoyrlist[pageIndex]
                                  .stories![storyIndex]
                                  .src
                                  .toString(),
                              autoPlay: true,
                            )
                          : Image.network(
                              stoyrlist[pageIndex]
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
                            stoyrlist[pageIndex].model!.img!,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(stoyrlist[pageIndex].model!.name!),
                        const Expanded(
                          child: Text(""),
                        ),
                        Text(stoyrlist[pageIndex].stories![storyIndex].date!)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          storyLength: (pageIndex) {
            return stoyrlist[pageIndex].stories!.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
          pageLength: stoyrlist.length,
        ),
      ),
    );
  }
}
