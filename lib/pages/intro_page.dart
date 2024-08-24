import 'package:tryt/components/button_text.dart';
import 'package:tryt/components/marquee_img.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marqueer/marqueer.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List resimler = [
    "https://w0.peakpx.com/wallpaper/774/394/HD-wallpaper-rashmika-mandana-kannada-actress.jpg",
    "https://w0.peakpx.com/wallpaper/438/908/HD-wallpaper-anime-anime-girls-short-hair-simple-dark-hair.jpg",
    "https://w0.peakpx.com/wallpaper/949/777/HD-wallpaper-virat-kohli-with-mrf-bat-virat-kohli-mrf-bat-cricketer-sports-king-kohli-indian-jersey.jpg",
    "https://w0.peakpx.com/wallpaper/685/172/HD-wallpaper-alone-alone-sad-mood-sad.jpg",
    "https://w0.peakpx.com/wallpaper/490/972/HD-wallpaper-romantic-sunset-love-i-love-you-couple-in-love.jpg",
    "https://w0.peakpx.com/wallpaper/608/329/HD-wallpaper-anime-anime-girls-digital-art-2d-artwork-portrait-display-vertical-bae-c.jpg",
    "https://w0.peakpx.com/wallpaper/808/980/HD-wallpaper-sidhu-moose-wala-live-grey-background-rapper-singer.jpg",
    "https://w0.peakpx.com/wallpaper/159/71/HD-wallpaper-illustration-artwork-digital-art-fan-art-drawing-fantasy-art-fantasy-girl-women-video-games-video-game-girls-video-game-characters-video-game-art-wickellia-league-of-legends-kai-sa-league.jpg",
    "https://w0.peakpx.com/wallpaper/635/339/HD-wallpaper-togetherness-i-love-you-couple-in-love-i-love-u-love-romantic-couple-love.jpg",
    "https://w0.peakpx.com/wallpaper/262/882/HD-wallpaper-pubg-girl-pubg-animation-pubg-game-pubg-mobile.jpg",
    "https://w0.peakpx.com/wallpaper/652/377/HD-wallpaper-bare-shoulders-green-eyes-eyes-brunette-long-hair-lipstick-women-looking-at-viewer-face-portrait-model.jpg",
    "https://w0.peakpx.com/wallpaper/784/281/HD-wallpaper-lonely-boy-art-solitude-loneliness-birds-guy-alone-sad.jpg",
    "https://w0.peakpx.com/wallpaper/993/372/HD-wallpaper-anime-anime-girls-digital-art-artwork-2d-portrait-display-vertical-mossi-artist-ichinose-shiki-blue-eyes-brunette-long-hair-barefoot.jpg",
    "https://w0.peakpx.com/wallpaper/638/643/HD-wallpaper-babasaheb-ambedkar-painting-babasaheb-ambedkar-painting-art-work-constitution-doctor.jpg",
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -15,
            right: -15,
            left: -15,
            bottom: -15,
            child: SizedBox(
                width: MediaQuery.of(context).size.width + 30,
                height: MediaQuery.of(context).size.height + 30,
                child: Column(
                  children: [
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(-0.02),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Marqueer.builder(
                          itemCount: resimler.length,
                          direction: MarqueerDirection.rtl,
                          restartAfterInteractionDuration:
                              const Duration(seconds: 10),
                          itemBuilder: (context, index) {
                            return MarqueeImg(
                              imageUrl: resimler[index],
                            );
                          },
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(-0.02),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Marqueer.builder(
                          itemCount: resimler.length,
                          direction: MarqueerDirection.rtl,
                          restartAfterInteractionDuration:
                              const Duration(seconds: 2),
                          itemBuilder: (context, index) {
                            return MarqueeImg(
                              imageUrl: resimler[index],
                            );
                          },
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(-0.02),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Marqueer.builder(
                          itemCount: resimler.length,
                          direction: MarqueerDirection.rtl,
                          restartAfterInteractionDuration:
                              const Duration(seconds: 1),
                          itemBuilder: (context, index) {
                            return MarqueeImg(
                              imageUrl: resimler[index],
                            );
                          },
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(-0.02),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Marqueer.builder(
                          itemCount: resimler.length,
                          direction: MarqueerDirection.rtl,
                          restartAfterInteractionDuration:
                              const Duration(seconds: 2),
                          itemBuilder: (context, index) {
                            return MarqueeImg(
                              imageUrl: resimler[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 100, left: 32, right: 32, bottom: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.3, 0.9],
                  colors: [
                    ThemeColors.getColorTheme(Config.themType)["color1"]!
                        .withOpacity(0.01),
                    ThemeColors.getColorTheme(Config.themType)["color1"]!
                        .withOpacity(1),
                    ThemeColors.getColorTheme(Config.themType)["color1"]!
                        .withOpacity(1),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 42,
                  ),
                  Text(
                    Config.langFulText.home!.title!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mukta(
                      fontSize: 25.6,
                      height: 1.1,
                      letterSpacing: -0.8,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    Config.langFulText.home!.description!,
                    style: GoogleFonts.firaSans(
                      fontSize: 16,
                      height: 1.3,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color7"],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ButtonText(
                    onpress: () {
                      Navigator.of(context).pushNamed("/login");
                    },
                    btnText: Config.langFulText.home!.button!,
                    rightIcon: const Icon(
                      Entypo.right_open_big,
                      size: 17.6,
                    ),
                    bgColor: ThemeColors.getColorTheme(
                        Config.themType)["colorprimary"]!,
                    textColor: ThemeColors.getColorTheme(
                        Config.themType)["color1fix"]!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
