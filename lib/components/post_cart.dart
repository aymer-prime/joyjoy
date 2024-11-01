import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:tryt/components/video_player.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/feeed_model.dart';
import 'package:tryt/pages/commonts_liste.dart';
import 'package:tryt/components/icon_text_button.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animated_dots.dart';

// ignore: must_be_immutable
class PostCart extends StatefulWidget {
  String username,
      postdate,
      profilImageUrl,
      subcategory,
      likecount,
      feedId,
      sendCount,
      connetCount;
  final VoidCallback onpress;
  final List<String> postText;
  bool userLiked;
  final List<Media>? mediainfo;
  PostCart(
      {super.key,
      required this.username,
      required this.postdate,
      required this.profilImageUrl,
      required this.subcategory,
      required this.likecount,
      required this.sendCount,
      required this.connetCount,
      required this.onpress,
      required this.postText,
      required this.feedId,
      required this.userLiked,
      required this.mediainfo});

  @override
  State<PostCart> createState() => _PostCartState();
}

class _PostCartState extends State<PostCart> {
  bool playderStatus = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onpress,
                  child: CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Colors
                        .grey[200], // Optional: background color while loading
                    child: ClipOval(
                      child: Image.network(
                        widget.profilImageUrl,
                        fit: BoxFit.cover,
                        width: 48.0,
                        height: 48.0,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                                child: AnimatedDots(
                              activeColor: ThemeColors.getColorTheme(
                                  Config.themType)["color5"]!,
                              inactiveColor: ThemeColors.getColorTheme(
                                  Config.themType)["color7"]!,
                            ));
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: GoogleFonts.firaSans(
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Image.asset(
                            "assets/images/blue-click.png",
                            width: 14.4,
                            height: 14.4,
                          ),
                        ),
                        Text(
                          widget.postdate,
                          style: GoogleFonts.firaSans(
                              fontSize: 14.4,
                              height: 1.3,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.getColorTheme(
                                  Config.themType)["color7"]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 1.6,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 1.6),
                      decoration: BoxDecoration(
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color3"],
                        borderRadius: BorderRadius.all(Radius.circular(4.8)),
                      ),
                      child: Text(
                        widget.subcategory,
                        style: GoogleFonts.firaSans(
                          fontSize: 11.2,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: (widget.mediainfo == null) ? false : true,
            child: const SizedBox(
              height: 11.2,
            ),
          ),
          if (widget.mediainfo!.isNotEmpty)
            Visibility(
              visible: (widget.mediainfo == null) ? false : true,
              child: (widget.mediainfo != null)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 11.2),
                      child: SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 450.0,
                                enlargeCenterPage: true,
                                aspectRatio: 2.0,
                                enableInfiniteScroll: false,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                              items: widget.mediainfo?.map((media) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: (media.video == 0)
                                          ? InstaImageViewer(
                                              child: Image.network(
                                                media.src!,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : VideoPlayer(
                                              url: widget.mediainfo![0].src!,
                                              autoPlay: playderStatus,
                                            ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            if (widget.mediainfo!.length > 1)
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: widget.mediainfo!.map((media) {
                                        int index =
                                            widget.mediainfo!.indexOf(media);
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentIndex == index
                                                ? ThemeColors.getColorTheme(
                                                        Config.themType)[
                                                    "colorprimary"]
                                                : Colors
                                                    .white70, // Change colors as needed
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  : const Text(""),
            ),
          (widget.postText[0].isEmpty)
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: widget.postText[0],
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              showModalBottomSheet(
                                context: context,
                                useRootNavigator: true,
                                isScrollControlled: true,
                                isDismissible: false,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    maxChildSize: 0.97,
                                    initialChildSize: 0.7,
                                    builder: (BuildContext context,
                                        ScrollController scroll) {
                                      return CommentsListe(
                                        feedId: widget.feedId,
                                        scrollController: scroll,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          style: GoogleFonts.firaSans(
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                            //height: 1.3,
                            fontSize: 16,
                          ),
                          children: List.generate(
                            widget.postText.length,
                            (index) {
                              if (index > 0) {
                                return TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {},
                                  text: '#${widget.postText[index]}',
                                  style: GoogleFonts.firaSans(
                                    color: const Color(0xff1d9bf0),
                                    //height: 1.3,
                                    fontSize: 16,
                                  ),
                                );
                              }
                              return const TextSpan(text: "");
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 11.2),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                IconTextButton(
                  btnIcon: SvgPicture.asset(
                    (widget.userLiked)
                        ? "assets/svgs/liked-active.svg"
                        : "assets/svgs/liked.svg",
                    width: 19.2,
                    height: 19.2,
                    colorFilter: ColorFilter.mode(
                        (widget.userLiked)
                            ? ThemeColors.getColorTheme(
                                Config.themType)["colorprimary"]!
                            : ThemeColors.getColorTheme(
                                Config.themType)["color7"]!,
                        BlendMode.srcIn),
                  ),
                  counter: widget.likecount,
                  onpress: () async {
                    var data = {
                      "user_id": Config.userBilgi.userId,
                      "token": Config.userBilgi.token,
                      "lang": Config.lang,
                      "feed_id": widget.feedId,
                    };
                    var sonuc =
                        await Httpservices().postMethod("feed/like.php", data);
                    var body = json.decode(sonuc);
                    if (body["success"]) {
                      setState(() {
                        widget.userLiked = body["result"]["like"];
                        widget.likecount =
                            body["result"]["total_like"].toString();
                      });
                    }
                  },
                ),
                const SizedBox(
                  width: 32,
                ),
                IconTextButton(
                  btnIcon: SvgPicture.asset(
                    "assets/svgs/chat.svg",
                    width: 19.2,
                    height: 19.2,
                    colorFilter: ColorFilter.mode(
                        ThemeColors.getColorTheme(Config.themType)["color7"]!,
                        BlendMode.srcIn),
                  ),
                  counter: widget.connetCount,
                  onpress: () async {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      enableDrag: true,
                      isDismissible: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withOpacity(0.5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context)
                                .pop(); // Closes the bottom sheet
                          },
                          child: DraggableScrollableSheet(
                            maxChildSize: 0.97,
                            initialChildSize: 0.8,
                            builder: (BuildContext context,
                                ScrollController scroll) {
                              return GestureDetector(
                                behavior: HitTestBehavior
                                    .translucent, // Ensures inner taps are ignored for closing
                                onTap:
                                    () {}, // Absorbs the tap event inside the sheet
                                child: CommentsListe(
                                  feedId: widget.feedId,
                                  scrollController: scroll,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 32,
                ),
                IconTextButton(
                  btnIcon: SvgPicture.asset(
                    "assets/svgs/share.svg",
                    width: 19.2,
                    height: 19.2,
                    colorFilter: ColorFilter.mode(
                        ThemeColors.getColorTheme(Config.themType)["color7"]!,
                        BlendMode.srcIn),
                  ),
                  counter: widget.sendCount,
                  onpress: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
