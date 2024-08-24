import 'dart:convert';
import 'dart:io';
import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/components/chat_icon_input.dart';
import 'package:tryt/components/chat_text_blog.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/models/chat_detail_model.dart';
import 'package:tryt/pages/chat_add_img.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  const ChatDetailPage({super.key, required this.chatId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ThemeController themeController = Get.put(ThemeController());
  final TextEditingController chatMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  late String imageSelect = "";
  bool isWriting = false, loadinBar = false, autofocus = false;
  @override
  void initState() {
    super.initState();
    loadPage();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (page * Config.langFulText.chat!.detail!.perpage! ==
            themeController.chatDetayListe.first.chatHistory!.length) {
          page = page + 1;
          setState(() {
            loadinBar = true;
          });
          nextPage(page);
        }
      }
    });
  }

  loadPage() async {
    themeController.chatDetayListe.value = [];
    page = 1;
    themeController.getChatDetayAdd(widget.chatId, page);
  }

  nextPage(int page) async {
    await themeController.getChatDetayNextAdd(widget.chatId, page);
    setState(() {
      loadinBar = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    themeController.chatDetayListe.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: false,
              pinned: true,
              surfaceTintColor:
                  ThemeColors.getColorTheme(Config.themType)["color1"],
              backgroundColor:
                  ThemeColors.getColorTheme(Config.themType)["color1"],
              leading: const AppBarBack(
                leftPadding: 0,
              ),
              title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Obx(() {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(68),
                              image: DecorationImage(
                                image: NetworkImage(
                                  (themeController.chatDetayListe.isEmpty)
                                      ? "https://joyjoy.ai/assets/img/user-img.png?v=2.1.51722622211"
                                      : themeController
                                          .chatDetayListe.first.model!.img
                                          .toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.8,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (themeController.chatDetayListe.isEmpty)
                                    ? ""
                                    : themeController
                                        .chatDetayListe.first.model!.name!,
                                style: GoogleFonts.firaSans(
                                  fontSize: 16,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color10"],
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(
                                height: 1.6,
                              ),
                              Text(
                                (themeController.chatDetayListe.isEmpty)
                                    ? ""
                                    : themeController.chatDetayListe.first
                                        .model!.subcategory!,
                                style: GoogleFonts.firaSans(
                                  fontSize: 11.2,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color7"],
                                ),
                              ),
                              Text(
                                maxLines: 1,
                                style: GoogleFonts.firaSans(
                                  fontSize: 12.8,
                                  height: 1.3,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color6"],
                                ),
                                overflow: TextOverflow.ellipsis,
                                "20..06.2024 23:29",
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  })),
              actions: [
                GestureDetector(
                  child: Icon(
                    Icons.info_outline,
                    size: 26,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    return loadPage();
                  },
                  child: Obx(() {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemBuilder: (context, index) {
                        if (index <
                            themeController
                                .chatDetayListe.first.chatHistory!.length) {
                          var datam = themeController
                              .chatDetayListe.first.chatHistory![index];
                          return ChatTextBlog(
                            userStatu: datam.user == "1" ? true : false,
                            msgText: datam.message!,
                            msgTime: datam.date!,
                            msgImage: datam.imageUrl.toString(),
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
                      itemCount: (themeController.chatDetayListe.isEmpty)
                          ? 0
                          : themeController
                                  .chatDetayListe.first.chatHistory!.length +
                              1,
                      padding: const EdgeInsets.all(0),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "😂",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "❤️",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "😍",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "😊",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "😢",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "😲",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "👍🏼",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "👏🏼",
                          ),
                        ),
                        Expanded(
                          child: ChatIconInput(
                            onpress: (val) {
                              chatMessage.text = chatMessage.text + val;
                            },
                            iconText: "🔥",
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isWriting,
                      child: Text((themeController.chatDetayListe.isEmpty)
                          ? ""
                          : "${themeController.chatDetayListe.first.model!.name.toString()} Yazıyor ..."),
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: chatMessage,
                        builder: (context, value, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["color2"],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: (imageSelect == "") ? false : true,
                                  child: (imageSelect != "")
                                      ? Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Stack(
                                            children: [
                                              Image.file(
                                                width: 120,
                                                height: 90,
                                                File(imageSelect),
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageSelect = "";
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.red,
                                                    ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const Text("Deneme"),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.send,
                                  maxLines: 5,
                                  minLines: 1,
                                  controller: chatMessage,
                                  autofocus: autofocus,
                                  onEditingComplete: () async {
                                    await sendeMessage();
                                  },
                                  onChanged: (val) {
                                    chatMessage.text = val;
                                  },
                                  style: TextStyle(
                                      color: ThemeColors.getColorTheme(
                                          Config.themType)["color10"]),
                                  decoration: InputDecoration(
                                    hintText: Config.langFulText.chat!.detail!
                                        .errorMessage!.writeMessage!,
                                    filled: true,
                                    prefixIcon: IconButton(
                                      onPressed: () async {
                                        try {
                                          var returnData =
                                              await showModalBottomSheet(
                                            context: context,
                                            useRootNavigator: true,
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (BuildContext context) {
                                              return DraggableScrollableSheet(
                                                maxChildSize: 0.96,
                                                initialChildSize: 0.7,
                                                builder: (BuildContext context,
                                                    ScrollController scroll) {
                                                  return ChatAddImg(
                                                    scrollController: scroll,
                                                  );
                                                },
                                              );
                                            },
                                          );
                                          setState(() {
                                            imageSelect = returnData["resimdata"];
                                          });
                                        } catch (e) {}
                                      },
                                      icon: Icon(LineariconsFree.paperclip,
                                          color: ThemeColors.getColorTheme(
                                              Config.themType)["color10"]),
                                    ),
                                    suffixIcon: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: (chatMessage.text == "" &&
                                                imageSelect == "")
                                            ? ThemeColors.getColorTheme(
                                                Config.themType)["color4"]
                                            : ThemeColors.getColorTheme(
                                                Config.themType)["color10"],
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await sendeMessage();
                                        },
                                        icon: Icon(
                                          Icons.arrow_upward,
                                          color: ThemeColors.getColorTheme(
                                              Config.themType)["color1"],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  sendeMessage() async {
    var url = Uri.parse("${Config.siteUrl}tryt/send-message.php");
    var request = http.MultipartRequest('post', url);
    request.fields['message'] = chatMessage.text;
    request.fields['user_id'] = Config.userBilgi.userId!;
    request.fields['token'] = Config.userBilgi.token!;
    request.fields['lang'] = Config.lang;
    request.fields['chat_id'] =
        themeController.chatDetayListe.first.chatId.toString();
    if (imageSelect != "") {
      var file = File(imageSelect);
      var fileName = file.path.split('/').last;
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageSelect,
          filename: fileName,
        ),
      );
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responsedata = await http.Response.fromStream(response);
      var body = json.decode(responsedata.body);
      print(body);
      if (body["success"]) {
        themeController.getChatDetayAddData(
          ChatHistory(
            user: "1",
            message: body["result"]["message"] ?? "",
            imageUrl: body["result"]["image_url"] ?? "",
            date: body["result"]["date"],
          ),
        );
        setState(() {
          isWriting = true;
          imageSelect = "";
          chatMessage.text = "";
        });
        await getCevapGetir(themeController.chatDetayListe.first.chatId!);
      } else {
        Config.genelModal(
          // ignore: use_build_context_synchronously
          context,
          AlertBox(
              alertIcon: (body["success"]) ? Icons.check : Icons.priority_high,
              alertColor: (body["success"])
                  ? ThemeColors.getColorTheme(Config.themType)["colorsuccess"]!
                  : ThemeColors.getColorTheme(Config.themType)["colordanger"]!,
              title: (body["success"])
                  ? Config.langFulText.general!.success!
                  : Config.langFulText.general!.error!,
              content: body["message"],
              btnText: Config.langFulText.general!.okay!),
        );
      }
    } else {}
  }

  getCevapGetir(String chatId) async {
    var data = {
      "user_id": Config.userBilgi.userId,
      "token": Config.userBilgi.token,
      "lang": Config.lang,
      "chat_id": chatId,
    };
    var sonuc =
        await Httpservices().postMethod("tryt/send-message-model.php", data);
    var body = json.decode(sonuc);
    if (body["success"]) {
      themeController.getChatDetayAddData(
        ChatHistory(
            user: "0",
            message: body["result"]["message"],
            imageUrl: "",
            date: body["result"]["date"]),
      );
      setState(() {
        isWriting = false;
      });
    }
  }
}
