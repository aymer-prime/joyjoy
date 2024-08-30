import 'package:tryt/components/chat_stroy.dart';
import 'package:tryt/components/chatlist.dart';
import 'package:tryt/components/user_modal_profil.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/pages/choose_pages/choose_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryt/pages/model_detay_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final ThemeController themeController = Get.put(ThemeController());
  int page = 1;
  bool loadinBar = false;

  @override
  void initState() {
    super.initState();
    loadPage(page);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (page * Config.langFulText.chat!.perpage! ==
            themeController.chatListe.length) {
          page = page + 1;
          setState(() {
            loadinBar = true;
          });
          nextpage(page);
        }
      }
    });
  }

  loadPage(int page) async {
    page = 1;
    await themeController.getChatListeAdd(page);
    await themeController.getSuggestionAdd();
    setState(() {
      loadinBar = false;
    });
  }

  nextpage(int page) async {
    await themeController.getChatListeAdd(page);
    setState(() {
      loadinBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  Config.langFulText.chat!.pageTitle!,
                  style: GoogleFonts.mukta(
                    fontSize: 32,
                    height: 1.1,
                    letterSpacing: -0.8,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            return loadPage(page);
          },
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      Config.langFulText.chat!.suggestionsForYou!,
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.3,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                      ),
                    ),
                    const Expanded(
                      child: Text(""),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChoosePage(),
                          ),
                        );
                      },
                      child: Text(
                        Config.langFulText.general!.all!,
                        style: GoogleFonts.firaSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.3,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color5"],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 94.6,
                child: Obx(() {
                  if (themeController.suggestionlist.isEmpty) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: ThemeColors.getColorTheme(
                          Config.themType)["colorprimary"],
                    ));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.8),
                          child: ChatStroy(
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
                              //         .suggestionlist[index].modelId!,
                              //   ),
                              // );
                            },
                            userImage:
                                themeController.suggestionlist[index].img!,
                            userTitle:
                                themeController.suggestionlist[index].name!,
                          ),
                        );
                      },
                      itemCount: themeController.suggestionlist.length,
                    );
                  }
                }),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  child: Obx(() {
                    return Text(
                      "${Config.langFulText.chat!.chatHistory!} (${themeController.chatListe.length})",
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        height: 1.3,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  if (themeController.chatListe.isEmpty) {
                    // Display a message or placeholder when the chatListe is empty
                    return Center(
                        child: CircularProgressIndicator(
                      color: ThemeColors.getColorTheme(
                          Config.themType)["colorprimary"],
                    ));
                  } else {
                    // Display the ListView.builder when the chatListe has items
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      controller: _scrollController,
                      itemCount: themeController.chatListe.length +
                          (loadinBar ? 1 : 0),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        if (index < themeController.chatListe.length) {
                          return Chatlist(
                            userName:
                                themeController.chatListe[index].model!.name!,
                            userImage:
                                themeController.chatListe[index].model!.img!,
                            subcategory: themeController
                                .chatListe[index].model!.subcategory!,
                            mesajtext:
                                themeController.chatListe[index].lastMessage !=
                                        null
                                    ? themeController
                                        .chatListe[index].lastMessage!.message!
                                    : "",
                            sendate:
                                themeController.chatListe[index].lastMessage !=
                                        null
                                    ? themeController
                                        .chatListe[index].lastMessage!.date!
                                    : "",
                            onpress: () {
                              Navigator.of(context, rootNavigator: true).pushNamed(
                                  "/chatDetail/${themeController.chatListe[index].chatId!}");
                            },
                            onlongPress: () {
                              showBottomMenu(context);
                            },
                          );
                        } else {
                          return Visibility(
                            visible: loadinBar,
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.transparent,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
                width: 120,
                height: 5,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
              ),
              title: Text(
                'Sil',
                style: TextStyle(
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"]!),
              ),
              onTap: () {
                // Silme işlemi
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      },
    );
  }
}
