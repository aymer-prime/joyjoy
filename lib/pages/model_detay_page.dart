import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/components/video_player.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ModelDetayPage extends StatefulWidget {
  const ModelDetayPage({super.key});

  @override
  State<ModelDetayPage> createState() => _ModelDetayPageState();
}

class _ModelDetayPageState extends State<ModelDetayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBack(
          leftPadding: 0,
        ),
        surfaceTintColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor:
                      ThemeColors.getColorTheme(Config.themType)["color4"],
                  backgroundImage:
                      const AssetImage('assets/images/user-img.png'),
                  foregroundImage: const NetworkImage(
                    "https://joyjoy.ai/files/model/9/11/asli-500-orj.jpg?v=2.1.51722618747",
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "23,2B",
                      style: GoogleFonts.firaSans(
                        height: 1.25,
                        fontSize: 17.6,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Gönderi",
                      style: GoogleFonts.firaSans(
                        height: 1.25,
                        fontSize: 14.4,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "23,2B",
                      style: GoogleFonts.firaSans(
                        height: 1.25,
                        fontSize: 17.6,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Takipçi",
                      style: GoogleFonts.firaSans(
                        height: 1.25,
                        fontSize: 14.4,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "23,2B",
                      style: GoogleFonts.firaSans(
                        height: 1.25,
                        fontSize: 17.6,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Takip",
                      style: GoogleFonts.firaSans(
                        height: 1.25,
                        fontSize: 14.4,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          RichText(
            text: TextSpan(
              text: 'Aslı, ',
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w600,
                height: 1,
                fontSize: 16,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
              ),
              children: [
                TextSpan(
                  text: '23',
                  style: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    height: 1,
                    fontSize: 16,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 1.6),
                decoration: BoxDecoration(
                  color: ThemeColors.getColorTheme(Config.themType)["color3"],
                  borderRadius: BorderRadius.circular(4.8),
                ),
                child: Text(
                  "Sevgili Adayı",
                  style: GoogleFonts.firaSans(
                    fontSize: 12.8,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Expanded(
                child: Text(""),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Büyüleyici, Şık, Zarif, Alımlı, Göz alıcı",
            style: GoogleFonts.firaSans(
              fontSize: 14.4,
              height: 1.25,
              color: ThemeColors.getColorTheme(Config.themType)["color10"],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ThemeColors.getColorTheme(
                          Config.themType)["colorprimary"],
                    ),
                    child: Text(
                      Config.langFulText.general!.startTalking!,
                      style: GoogleFonts.firaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color1fix"],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color3"],
                    ),
                    child: Text(
                      "Takip Et",
                      style: GoogleFonts.firaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"]!,
                          width: 1.0,
                        ),
                      )),
                      child: Icon(
                        Typicons.th_outline,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"]!,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      )),
                      child: Icon(
                        FontAwesome5.list_ul,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"]!,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AlignedGridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            shrinkWrap: true,
            primary: false,
            itemCount: 15,
            itemBuilder: (context, index) {
              if (index % 2 == 0) {
                return Container(
                  height: MediaQuery.of(context).size.width / 2,
                  color: Colors.white,
                  child: Image.network(
                      "https://joyjoy.ai/files/feed/26/4/4-500-orj.jpg"),
                );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: const VideoPlayer(
                    url: "https://joyjoy.ai/files/feed/25/2/2.mp4",
                    autoPlay: false,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
