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
  const CommentsUser({
    super.key,
    required this.onReply,
    required this.userImage,
    required this.userName,
    required this.addDate,
    required this.commentsText,
    required this.commentId,
    required this.totalLike,
    required this.totalReply,
    required this.userLike,
  });

  @override
  State<CommentsUser> createState() => CommentsUserState();
}

class CommentsUserState extends State<CommentsUser> {
  List<SubCommentsmodel> subcommetListe = [];
  List<String> commentParts = [];
  int pageId = 1;
  String totalLike = "0";
  bool userLike = false;

  @override
  void initState() {
    super.initState();
    totalLike = widget.totalLike;
    userLike = widget.userLike;
    splitComment(widget.commentsText);
  }

  void splitComment(String input) {
    RegExp regExp = RegExp(r'@\w+');
    Iterable<RegExpMatch> matches = regExp.allMatches(input);

    List<String> parts = [];

    int lastMatchEnd = 0;

    for (final match in matches) {
      if (lastMatchEnd != match.start) {
        parts.add(input.substring(lastMatchEnd, match.start));
      }
      parts.add(match.group(0)!);
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < input.length) {
      parts.add(input.substring(lastMatchEnd));
    }

    commentParts = parts;
  }

  getSubComments(String page, commentsId) async {
    var subliste = await getSubCommentsList(page, commentsId);
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
                  InkWell(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
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
              RichText(
                text: TextSpan(
                    children: commentParts.map((part) {
                  return TextSpan(
                    text: part,
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.4,
                      color: part.startsWith('@')
                          ? Colors.blue
                          : ThemeColors.getColorTheme(
                              Config.themType)["color10"],
                      height: 1.26,
                    ),
                  );
                }).toList()),
              ),
              // Text(
              //   widget.commentsText,
              //   style: GoogleFonts.firaSans(
              //     fontWeight: FontWeight.w400,
              //     fontSize: 14.4,
              //     color: ThemeColors.getColorTheme(Config.themType)["color10"],
              //     height: 1.26,
              //   ),
              // ),
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
                        var comment = subcommetListe[index2]
                            .comment!
                            .replaceAll(RegExp(r'<\/?span>'), '');
                        return CommentsUser(
                          onReply: widget.onReply,
                          userImage: subcommetListe[index2].user!.img!,
                          userName: subcommetListe[index2].user!.username!,
                          commentId: subcommetListe[index2].id!,
                          commentsText: comment,
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
