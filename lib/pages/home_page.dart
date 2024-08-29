import 'package:tryt/components/post_cart.dart';
import 'package:tryt/components/story_avatar.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/pages/model_detay_page.dart';
import 'package:tryt/pages/new_story_detail.dart';
import 'package:tryt/pages/story_detail.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final ThemeController themeController = Get.put(ThemeController());
  int page = 1;
  bool loadinBar = false;
  @override
  void initState() {
    print(
      '******************************Home****************************************',
    );
    super.initState();
    getPageLoadin(page);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (page * Config.langFulText.feed!.perpage! ==
            themeController.feedmodel.length) {
          page = page + 1;
          setState(() {
            loadinBar = true;
          });
          nextPage(page);
        }
      }
    });
  }

  getPageLoadin(int page) async {
    themeController.feedmodel.value = [];
    themeController.getStoryAdd();
    nextPage(page);
  }

  nextPage(int page) async {
    await themeController.getFeedAdd(page);
    setState(() {
      loadinBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              surfaceTintColor:
                  ThemeColors.getColorTheme(Config.themType)["color1"],
              backgroundColor:
                  ThemeColors.getColorTheme(Config.themType)["color1"],
              floating: true,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Image.asset(
                  (Config.themType == "dark")
                      ? "assets/images/logo-white.png"
                      : "assets/images/logo-red.png",
                  width: 149.54,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesome.ellipsis_vert,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                  ),
                ),
              ],
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () {
              page = 1;
              return getPageLoadin(page);
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              children: [
                const SizedBox(
                  height: 9.48,
                ),
                SizedBox(
                  height: 101.8,
                  child: Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 12.8,
                          ),
                          child: StoryAvatar(
                            onpress: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => NewStoryDetail(
                                    storyPage: index,
                                    storyList: themeController.stoyrlist,
                                  ),
                                ),
                              );
                            },
                            userName:
                                themeController.stoyrlist[index].model!.name!,
                            userImageUrl:
                                themeController.stoyrlist[index].model!.img!,
                          ),
                        );
                      },
                      itemCount: themeController.stoyrlist.length,
                    );
                  }),
                ),
                const SizedBox(height: 16.0),
                Obx(() {
                  return (themeController.feedmodel.isNotEmpty)
                      ? ListView.separated(
                          padding: const EdgeInsets.all(0),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: themeController.feedmodel.length + 1,
                          itemBuilder: (context, index) {
                            if (index < themeController.feedmodel.length) {
                              return PostCart(
                                feedId: themeController.feedmodel[index].id!,
                                username: themeController
                                    .feedmodel[index].model!.name!,
                                subcategory: themeController
                                    .feedmodel[index].model!.subcategory!,
                                profilImageUrl: themeController
                                    .feedmodel[index].model!.img!,
                                postText: themeController.feedmodel[index].text!
                                    .split("#"),
                                postdate:
                                    themeController.feedmodel[index].date!,
                                likecount:
                                    themeController.feedmodel[index].totalLike!,
                                connetCount: themeController
                                    .feedmodel[index].totalComment!,
                                sendCount: themeController
                                    .feedmodel[index].totalShare!,
                                userLiked:
                                    themeController.feedmodel[index].userLike!,
                                mediainfo:
                                    themeController.feedmodel[index].media,
                                onpress: () async {
                                  Get.to(
                                    transition: Transition.rightToLeft,
                                    ModelDetayPage(
                                        modelId: themeController
                                            .feedmodel[index].model!.modelId!),
                                  );
                                  // Config.modalCenter(
                                  //   context,
                                  //   UserModalProfil(
                                  //     modelId: themeController
                                  //         .feedmodel[index].model!.modelId!,
                                  //   ),
                                  // );
                                },
                              );
                            } else {
                              return Visibility(
                                visible: loadinBar,
                                child: (loadinBar)
                                    ? const CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.transparent,
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text(""),
                              );
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 22.4,
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["colorborder1"],
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
