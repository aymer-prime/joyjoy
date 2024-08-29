import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryt/models/models_model.dart';

class UserlisteCard extends StatefulWidget {
  final String modelId, title, imageUrl, yas, subTitle, subcategory, numLikes;
  final bool liked;
  final VoidCallback onpress;
  const UserlisteCard({
    super.key,
    required this.modelId,
    required this.title,
    required this.subcategory,
    required this.imageUrl,
    required this.onpress,
    required this.yas,
    required this.subTitle,
    required this.numLikes,
    required this.liked,
  });

  @override
  State<UserlisteCard> createState() => _UserlisteCardState();
}

class _UserlisteCardState extends State<UserlisteCard> {
  late bool isLiked;
  late String numLiked;

  Future<void> onLikePressed(String modelId) async {
    var getmodeller = await toggleModelLike(modelId: modelId);
    print('${getmodeller.totalLike},${getmodeller.userLike}');
    setState(() {
      isLiked = getmodeller.userLike ?? false;
      numLiked = '${getmodeller.totalLike}' ?? '0';
    });
  }

  @override
  void initState() {
    isLiked = widget.liked;
    numLiked = widget.numLikes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.8),
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 16, right: 16),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.8),
                    bottomRight: Radius.circular(12.8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(1, 0, 0, 0),
                    Color.fromARGB(150, 0, 0, 0),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "${widget.title},",
                      style: GoogleFonts.firaSans(
                        fontSize: 28.8,
                        height: 1.3,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color1fix"],
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        const TextSpan(text: " "),
                        TextSpan(
                          text: widget.yas,
                          style: GoogleFonts.firaSans(
                            fontSize: 28.8,
                            height: 1.3,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color1fix"],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3.2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.4,
                      horizontal: 12.8,
                    ),
                    decoration: BoxDecoration(
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color1"],
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      widget.subcategory ?? "Sevigli Adayı",
                      style: GoogleFonts.firaSans(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontSize: 12.8,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4.8,
                  ),
                  Text(
                    widget.subTitle,
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w300,
                      color: ThemeColors.getColorTheme(
                          Config.themType)["color3fix"],
                      fontSize: 14.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () async {
                await onLikePressed(widget.modelId);
              },
              child: Container(
                height: 40,
                width: 32,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: ThemeColors.getColorTheme(Config.themType)["color1"],
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLiked
                        ? Icon(
                            FontAwesome.heart,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["colorprimary"],
                            size: 16,
                          )
                        : Icon(
                            FontAwesome.heart_empty,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color10"],
                            size: 16,
                          ),
                    const SizedBox(height: 2.0),
                    if (isLiked)
                      Text(
                        widget.numLikes ?? "105",
                        style: GoogleFonts.mukta(
                          fontSize: 11.2,
                          height: 1,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
