import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/components/post_cart.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/feeed_model.dart';

class ModelPostsPage extends StatefulWidget {
  final List<Feedmodel> modelPostsList;
  final String modelName;
  final VoidCallback onFollow;
  final int index;
  const ModelPostsPage({
    super.key,
    required this.modelPostsList,
    required this.modelName,
    required this.onFollow,
    required this.index,
  });

  @override
  State<ModelPostsPage> createState() => _ModelPostsPageState();
}

class _ModelPostsPageState extends State<ModelPostsPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => itemScrollController.jumpTo(
              index: widget.index,
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        centerTitle: false,
        title: Text(
          widget.modelName,
          style: TextStyle(
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: const AppBarBack(),
        actions: [
          TextButton(
            onPressed: widget.onFollow,
            child: const Text(
              'Follow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ScrollablePositionedList.separated(
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: widget.modelPostsList.length,
        itemBuilder: (context, index) {
          return PostCart(
            feedId: widget.modelPostsList[index].id!,
            username: widget.modelPostsList[index].model!.name!,
            subcategory: widget.modelPostsList[index].model!.subcategory!,
            profilImageUrl: widget.modelPostsList[index].model!.img!,
            postText: widget.modelPostsList[index].text!.split("#"),
            postdate: widget.modelPostsList[index].date!,
            likecount: widget.modelPostsList[index].totalLike!,
            connetCount: widget.modelPostsList[index].totalComment!,
            sendCount: widget.modelPostsList[index].totalShare!,
            userLiked: widget.modelPostsList[index].userLike!,
            mediainfo: widget.modelPostsList[index].media ?? [],
            onpress: () async {},
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 22.4,
            color: ThemeColors.getColorTheme(Config.themType)["colorborder1"],
          );
        },
      ),
    );
  }
}
