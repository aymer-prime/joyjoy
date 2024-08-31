import 'dart:convert';
import 'dart:io';

import 'package:fluttericon/font_awesome_icons.dart';
import 'package:tryt/components/EmojiRow.dart';
import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/comments_user.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/comments_model.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryt/services/prefservice.dart';

class CommentsListe extends StatefulWidget {
  final String feedId;
  final ScrollController scrollController;
  const CommentsListe({
    super.key,
    required this.feedId,
    required this.scrollController,
  });

  @override
  State<CommentsListe> createState() => _CommentsListeState();
}

class _CommentsListeState extends State<CommentsListe> {
  List<Commentsmodel> commentsListe = [];
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  bool isLoading = false;
  bool isReplaying = false;
  bool hasError = false;
  String comment = "", commentId = "", commentTo = '';
  int page = 1;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
    _loadComments();
  }

  void _handleScroll() {
    if (widget.scrollController.position.maxScrollExtent ==
        widget.scrollController.position.pixels) {
      if (page * Config.langFulText.feed!.comment!.perpage! ==
          commentsListe.length) {
        setState(() {
          page++;
        });
        _loadComments();
      }
    }
  }

  Future<void> _loadComments() async {
    setState(() {
      isLoading = true;
    });
    try {
      final commets = await getCommentsList(page.toString(), widget.feedId);
      setState(() {
        commentsListe.addAll(commets);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  Future<void> _postComment() async {
    setState(() {
      isLoading = true;
    });
    final body = commentId.isNotEmpty
        ? {
            "user_id": Config.userBilgi.userId,
            "token": Config.userBilgi.token,
            "feed_id": widget.feedId,
            "comment_id": commentId,
            "lang": Config.lang,
            "comment": commentController.text,
          }
        : {
            "user_id": Config.userBilgi.userId,
            "token": Config.userBilgi.token,
            "feed_id": widget.feedId,
            "lang": Config.lang,
            "comment": commentController.text,
          };

    final result = await Httpservices().postMethod(
      commentId.isNotEmpty
          ? "feed/comments-replys.php"
          : "feed/send-comment.php",
      body,
    );
    final response = json.decode(result);

    // ignore: use_build_context_synchronously
    // Navigator.pop(context);

    if (response["success"] == true) {
      commentController.text = "";
      if (commentId.isNotEmpty) {
        CommentsUserState().getSubComments("1", commentId);
      } else {
        commentsListe = [];
        _loadComments();
      }
    } else {
      // ignore: use_build_context_synchronously
      Config.genelModal(
        context,
        AlertBox(
          alertIcon: Icons.priority_high,
          alertColor:
              ThemeColors.getColorTheme(Config.themType)["colordanger"]!,
          title: Config.langFulText.general!.error!,
          content: response["message"],
          btnText: Config.langFulText.general!.okay!,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        title: Text(
          Config.langFulText.feed!.comment!.title!,
          style: GoogleFonts.mukta(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            height: 1.1,
            letterSpacing: -0.8,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            color: ThemeColors.getColorTheme(
                                Config.themType)["colorprimary"]),
                      )
                    : hasError
                        ? Column(
                            children: [
                              Text(
                                'Error: ${Config.langFulText.feed!.comment!.noComment!.title!}',
                                style: GoogleFonts.firaSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19.2,
                                  color: ThemeColors.getColorTheme(
                                      Config.themType)["color7"],
                                  height: 1.26,
                                ),
                              ),
                              const SizedBox(height: 32),
                              ButtonText(
                                onpress: () async {
                                  _loadComments();
                                },
                                btnText: 'Retry',
                                bgColor: ThemeColors.getColorTheme(
                                    Config.themType)["colorprimary"]!,
                                textColor: Colors.white,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ButtonText(
                                onpress: () async {
                                  await PrefService().setString("email", "");
                                  await PrefService().setString("password", "");
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamedAndRemoveUntil(
                                          '/', (Route<dynamic> route) => false);
                                },
                                btnText: 'Log Out',
                                bgColor: Colors.transparent,
                                textColor: ThemeColors.getColorTheme(
                                    Config.themType)["colorprimary"]!,
                              )
                            ],
                          )
                        : commentsListe.isNotEmpty
                            ? ListView.builder(
                                controller: widget.scrollController,
                                itemBuilder: (context, index) {
                                  return CommentsUser(
                                    onReply: () {
                                      isReplaying = true;
                                      commentFocusNode.requestFocus();
                                      commentId = commentsListe[index].id!;
                                      commentTo =
                                          '@${commentsListe[index].user!.username}';
                                      commentController.text = "$commentTo ";
                                    },
                                    userImage:
                                        commentsListe[index].user!.img ?? "",
                                    userName:
                                        commentsListe[index].user!.username ??
                                            "guest",
                                    commentId: commentsListe[index].id ?? "0",
                                    commentsText:
                                        commentsListe[index].comment ?? "",
                                    totalLike:
                                        commentsListe[index].totalLike ?? "0",
                                    totalReply:
                                        commentsListe[index].totalReply ?? "0",
                                    addDate: commentsListe[index].date ?? "",
                                    userLike:
                                        commentsListe[index].user!.userLike ??
                                            false,
                                  );
                                },
                                itemCount: commentsListe.length,
                              )
                            : Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Config.langFulText.feed!.comment!
                                          .noComment!.title!,
                                      style: GoogleFonts.firaSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 19.2,
                                        color: ThemeColors.getColorTheme(
                                            Config.themType)["color7"],
                                        height: 1.26,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      Config.langFulText.feed!.comment!
                                          .noComment!.subtitle!,
                                      style: GoogleFonts.firaSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.8,
                                        color: ThemeColors.getColorTheme(
                                            Config.themType)["color6"],
                                        height: 1.26,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: commentController,
                        builder: (context, value, child) {
                          return Theme(
                            data: ThemeData(
                                inputDecorationTheme: Theme.of(context)
                                    .inputDecorationTheme
                                    .copyWith(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: isReplaying
                                            ? const BorderRadius.only(
                                                bottomLeft: Radius.circular(24),
                                                bottomRight:
                                                    Radius.circular(24),
                                              )
                                            : BorderRadius.circular(24.0),
                                        borderSide: BorderSide(
                                          color: ThemeColors.getColorTheme(
                                              Config.themType)["colorborder1"]!,
                                          width: 1,
                                        ),
                                      ),
                                    )),
                            child: Column(
                              children: [
                               EmojiRow(chatMessage: commentController),
                                if (isReplaying)
                                  Container(
                                    //width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ThemeColors.getColorTheme(
                                          Config.themType)["color2"],
                                      border: Border.all(
                                          color: ThemeColors.getColorTheme(
                                              Config.themType)["colorborder1"]!,
                                          width: 1),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '$commentTo profiline yanıt veriyorsun.',
                                          style: TextStyle(
                                            fontSize: 11.2,
                                            color: ThemeColors.getColorTheme(
                                                Config.themType)["color7"],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            commentController.clear();
                                            commentFocusNode.unfocus();
                                            setState(() {
                                              isReplaying = false;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                TextFormField(
                                  focusNode: commentFocusNode,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(
                                    color: ThemeColors.getColorTheme(
                                        Config.themType)["color10"],
                                  ),
                                  maxLines: 5,
                                  minLines: 1,
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    hintText: Config
                                        .langFulText.feed!.comment!.textbox!,
                                    filled: true,
                                    suffixIcon: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: (commentController.text == "")
                                            ? ThemeColors.getColorTheme(
                                                Config.themType)["color4"]
                                            : ThemeColors.getColorTheme(Config
                                                .themType)["colorprimary"],
                                      ),
                                      child: IconButton(
                                        onPressed:
                                            isLoading ? null : _postComment,
                                        icon: Icon(
                                          FontAwesome.paper_plane,
                                          color: ThemeColors.getColorTheme(
                                              Config.themType)["color1fix"],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
