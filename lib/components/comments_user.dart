import 'dart:convert';

import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/comments_model.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentsUser extends StatefulWidget {
  final VoidCallback onReply;
  final String userImage,
      userName,
      addDate,
      commentsText,
      commentId,
      totalLike,
      totalReply;
  final bool userLike;
  const CommentsUser(
      {super.key,
      required this.onReply,
      required this.userImage,
      required this.userName,
      required this.addDate,
      required this.commentsText,
      required this.commentId,
      required this.totalLike,
      required this.totalReply,
      required this.userLike});

  @override
  State<CommentsUser> createState() => CommentsUserState();
}

class CommentsUserState extends State<CommentsUser> {
  List<SubCommentsmodel> subcommetListe = [];
  int pageId = 1;
  String totalLike = "0";
  bool userLike = false;

  @override
  void initState() {
    super.initState();
    totalLike = widget.totalLike;
    userLike = widget.userLike;
  }

  getSubComments(String page, commentsId) async {
    var subliste = await getSubCommentsListe(page, commentsId);
    setState(() {
      subcommetListe.addAll(subliste);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(widget.userImage),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.userName,
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.4,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                      height: 1.26,
                    ),
                  ),
                  Text(
                    ' ${widget.addDate}',
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 11.2,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color7"],
                      height: 1.26,
                    ),
                  ),
                  const Expanded(child: Text("")),
                  GestureDetector(
                    onTap: () async {
                      var data = {
                        "user_id": Config.userBilgi.userId,
                        "token": Config.userBilgi.token,
                        "lang": Config.lang,
                        "comment_id": widget.commentId,
                      };
                      var sonuc = await Httpservices()
                          .postMethod("feed/comment-like.php", data);
                      var body = json.decode(sonuc);

                      if (body["success"]) {
                        setState(() {
                          userLike = body["result"]["like"];
                          totalLike = body["result"]["total_like"].toString();
                        });
                      } else {}
                    },
                    child: Column(
                      children: [
                        Icon(
                          (userLike)
                              ? FontAwesome.heart
                              : FontAwesome.heart_empty,
                          color: (userLike)
                              ? ThemeColors.getColorTheme(
                                  Config.themType)["colorprimary"]
                              : ThemeColors.getColorTheme(
                                  Config.themType)["color7"],
                          size: 16,
                        ),
                        Text(
                          totalLike,
                          style: GoogleFonts.firaSans(
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color7"],
                            fontSize: 11.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4.8,
              ),
              Text(
                widget.commentsText,
                style: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.4,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  height: 1.26,
                ),
              ),
              TextButton(
                onPressed: widget.onReply,
                child: Text(
                  Config.langFulText.feed!.comment!.reply!,
                  style: GoogleFonts.firaSans(
                    color: ThemeColors.getColorTheme(Config.themType)["color7"],
                    fontSize: 12.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              (subcommetListe.isNotEmpty)
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index2) {
                        return CommentsUser(
                          onReply: () {},
                          userImage: subcommetListe[index2].user!.img!,
                          userName: subcommetListe[index2].user!.username!,
                          commentId: subcommetListe[index2].id!,
                          commentsText: subcommetListe[index2].comment!,
                          totalLike: subcommetListe[index2].totalLike!,
                          totalReply: "0",
                          addDate: subcommetListe[index2].date!,
                          userLike: subcommetListe[index2].user!.userLike!,
                        );
                      },
                      itemCount: subcommetListe.length,
                    )
                  : Visibility(
                      visible: (subcommetListe.isNotEmpty)
                          ? false
                          : (widget.totalReply == "0" ||
                                  widget.totalReply == "")
                              ? false
                              : true,
                      child: TextButton(
                        onPressed: () {
                          getSubComments(pageId.toString(), widget.commentId);
                        },
                        child: Text(
                          "--- ${widget.totalReply} Diğer yanıtı Gör",
                          style: GoogleFonts.firaSans(
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color7"],
                            fontSize: 12.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
