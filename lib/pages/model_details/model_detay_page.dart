import 'package:get/get.dart';
import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/components/video_player/new_video_player.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/models/feeed_model.dart';
import 'package:tryt/models/modeldetail_model.dart';
import 'package:tryt/pages/model_details/model_posts_page.dart';
import 'package:video_player/video_player.dart';

class ModelDetayPage extends StatefulWidget {
  final String modelId;
  const ModelDetayPage({super.key, required this.modelId});

  @override
  State<ModelDetayPage> createState() => _ModelDetayPageState();
}

class _ModelDetayPageState extends State<ModelDetayPage> {
  List<Modeldetailmodel> modelbilgi = [];
  bool isLoading = true;

  loadPage() async {
    isLoading = true;
    var modelinfo = await getModalApi(widget.modelId, context);
    setState(() {
      modelbilgi.add(modelinfo);
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBack(
            //leftPadding: 0,
            ),
        surfaceTintColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
      ),
      body: isLoading
          ? const Center(
              child: LoadingModal(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: ThemeColors.getColorTheme(
                            Config.themType)["color4"],
                        backgroundImage:
                            const AssetImage('assets/images/user-img.png'),
                        foregroundImage: NetworkImage(
                          modelbilgi.first.img ??
                              "https://joyjoy.ai/files/model/9/11/asli-500-orj.jpg?v=2.1.51722618747",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            modelbilgi.first.totalPost ?? "0",
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
                            modelbilgi.first.totalFollower ?? "0",
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
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              modelbilgi.first.totalFollow ?? "0",
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                    text: '${modelbilgi.first.name}, ' ?? 'Aslı, ',
                    style: GoogleFonts.firaSans(
                      fontWeight: FontWeight.w600,
                      height: 1,
                      fontSize: 16,
                      color:
                          ThemeColors.getColorTheme(Config.themType)["color10"],
                    ),
                    children: [
                      TextSpan(
                        text: '${modelbilgi.first.age}' ?? '23',
                        style: GoogleFonts.firaSans(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          height: 1,
                          fontSize: 16,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1.6),
                      decoration: BoxDecoration(
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color3"],
                        borderRadius: BorderRadius.circular(4.8),
                      ),
                      child: Text(
                        '${modelbilgi.first.subcategory}' ?? "Sevgili Adayı",
                        style: GoogleFonts.firaSans(
                          fontSize: 12.8,
                          color: ThemeColors.getColorTheme(
                              Config.themType)["color10"],
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
                  modelbilgi.first.shortDescription ??
                      "Büyüleyici, Şık, Zarif, Alımlı, Göz alıcı",
                  style: GoogleFonts.firaSans(
                    fontSize: 14.4,
                    height: 1.25,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
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
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color3"],
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
                  crossAxisSpacing: 1.5,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: fakeFeed.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ModelPostsPage(
                            modelPostsList: fakeFeed,
                            modelName: modelbilgi.first.name!,
                            onFollow: () {},
                            index: index,
                          ),
                        );
                      },
                      child: SizedBox(
                          height: 200,
                          child: (fakeFeed[index].media![0].video == 0)
                              ? Image.network(
                                  fakeFeed[index].media![0].src!,
                                )
                              : NewVideoPlayer(
                                  url: fakeFeed[index].media![0].src!,
                                  mute: true,
                                )),
                    );

                    // if (index % 2 == 0) {
                    //   return Container(
                    //     height: MediaQuery.of(context).size.width / 2,
                    //     color: Colors.white,
                    //     child: Image.network(
                    //         "https://joyjoy.ai/files/feed/26/4/4-500-orj.jpg"),
                    //   );
                    // } else {
                    //   return SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 200,
                    //     child: const VideoPlayer(
                    //       url: "https://joyjoy.ai/files/feed/25/2/2.mp4",
                    //       autoPlay: false,
                    //     ),
                    //   );
                    // }
                  },
                ),
              ],
            ),
    );
  }
}

List<Feedmodel> fakeFeed = [
  Feedmodel.fromJson(
    {
      "id": "26",
      "text":
          "Alanya sahillerinde güneş batarken fırçam ve ben günün son ışıklarını kovalıyoruz 🎨  Bisikletim ve atım da maceralarımda bana eşlik ediyor 😉  Sohbet ve yeni dostluklar için her zaman açığım!  🌺 #sanat #yağlıboya #alanya #doğa #bisiklet #atlar",
      "total_like": "2",
      "total_comment": "20",
      "total_share": "0",
      "date": "1 ay önce",
      "media": [
        {
          "src": "https://joyjoy.ai/files/feed/26/4/4-500-orj.jpg?v=2.2.29",
          "video": 0,
          "video_thumb": null
        }
      ],
      "user_like": false,
      "model": {
        "model_id": "32cef82f0f64ae85352fd47ba1141082543f555a",
        "name": "Derya",
        "subcategory": "Sevgili Adayı",
        "img": "https://joyjoy.ai/files/model/8/57/derya-500-orj.jpg?v=2.2.29"
      }
    },
  ),
  Feedmodel.fromJson({
    "id": "25",
    "text":
        "Ayy, şu kalbimin ritmi bir türlü normale dönmüyor! 🔥 Bisikletle eve dönerken bile rüzgar bana o şarkının melodisini fısıldıyor sanki...  😉🎶",
    "total_like": "3",
    "total_comment": "8",
    "total_share": "0",
    "date": "1 ay önce",
    "media": [
      {
        "src": "https://joyjoy.ai/files/feed/25/2/2.mp4?v=2.2.29",
        "video": 1,
        "video_thumb": null
      },
      {
        "src": "https://joyjoy.ai/files/feed/25/2/2.mp4?v=2.2.29",
        "video": 0,
        "video_thumb":
            "https://joyjoy.ai/files/feed/25/3/3-500-orj.png?v=2.2.29"
      }
    ],
    "user_like": false,
    "model": {
      "model_id": "150da3c6d1bc63fba9d7bfbebda984374a5a599b",
      "name": "Banu",
      "subcategory": "Sevgili Adayı",
      "img": "https://joyjoy.ai/files/model/4/55/banu-500-orj.jpg?v=2.2.29"
    }
  }),
  Feedmodel.fromJson(
    {
      "id": "26",
      "text":
          "Alanya sahillerinde güneş batarken fırçam ve ben günün son ışıklarını kovalıyoruz 🎨  Bisikletim ve atım da maceralarımda bana eşlik ediyor 😉  Sohbet ve yeni dostluklar için her zaman açığım!  🌺 #sanat #yağlıboya #alanya #doğa #bisiklet #atlar",
      "total_like": "2",
      "total_comment": "20",
      "total_share": "0",
      "date": "1 ay önce",
      "media": [
        {
          "src": "https://joyjoy.ai/files/feed/26/4/4-500-orj.jpg?v=2.2.29",
          "video": 0,
          "video_thumb": null
        }
      ],
      "user_like": false,
      "model": {
        "model_id": "32cef82f0f64ae85352fd47ba1141082543f555a",
        "name": "Derya",
        "subcategory": "Sevgili Adayı",
        "img": "https://joyjoy.ai/files/model/8/57/derya-500-orj.jpg?v=2.2.29"
      }
    },
  ),
];
