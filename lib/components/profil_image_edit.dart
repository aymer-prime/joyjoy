import 'dart:convert';
import 'dart:io';

import 'package:tryt/components/alert_box.dart';
import 'package:tryt/components/loading_modal.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/controller/theme_controller.dart';
import 'package:tryt/services/httpservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilImageEdit extends StatefulWidget {
  final double paddingTop;
  final bool userNameStatus;
  const ProfilImageEdit({
    super.key,
    required this.paddingTop,
    required this.userNameStatus,
  });

  @override
  State<ProfilImageEdit> createState() => _ProfilImageEditState();
}

class _ProfilImageEditState extends State<ProfilImageEdit> {
  final ThemeController themeController = Get.put(ThemeController());
  File? _image;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        left: 16,
        right: 16,
        bottom: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Stack(
              children: [
                InkWell(
                  child: CircleAvatar(
                    radius: 56,
                    backgroundColor:
                        ThemeColors.getColorTheme(Config.themType)["color4"],
                    backgroundImage:
                        const AssetImage('assets/images/user-img.png'),
                    foregroundImage:
                        (themeController.userInfo.first.picture != null)
                            ? NetworkImage(
                                themeController.userInfo.first.picture.toString(),
                              )
                            : null,
                  ),
                  onTap:() {
                    showBottomMenu(context);
                  },
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      showBottomMenu(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color5"],
                        borderRadius: BorderRadius.circular(12.8),
                        border: Border.all(
                            width: 3,
                            color: ThemeColors.getColorTheme(
                                Config.themType)["color1"]!),
                      ),
                      child: const Icon(
                        FontAwesome.edit,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          Visibility(
            visible: !widget.userNameStatus,
            child: const SizedBox(
              height: 11.2,
            ),
          ),
          Visibility(
            visible: (themeController.userInfo.first.picture == null)
                ? false
                : !widget.userNameStatus,
            child: GestureDetector(
              onTap: () async {
                var data = {
                  "user_id": Config.userBilgi.userId,
                  "token": Config.userBilgi.token,
                  "lang": Config.lang,
                };
                var sonuc = await Httpservices()
                    .postMethod("profile/delete-img.php", data);
                var body = json.decode(sonuc);
                if (body["success"]) {
                  setState(() {
                    themeController.userInfo.first.picture = null;
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.red,
                ),
                child: Text(
                  "Resim Sil",
                  style: TextStyle(
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color3fix"],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.userNameStatus,
            child: const SizedBox(
              height: 11.2,
            ),
          ),
          Visibility(
            visible: widget.userNameStatus,
            child: Obx(
              () => Text(
                "${themeController.userInfo.first.name!} ${themeController.userInfo.first.surname!}",
                style: GoogleFonts.mukta(
                    fontWeight: FontWeight.w700,
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"],
                    fontSize: 19.2,
                    height: 1.1),
              ),
            ),
          ),
          Visibility(
            visible: widget.userNameStatus,
            child: Obx(
              () => Text(
                "@${themeController.userInfo.first.username!}",
                style: GoogleFonts.firaSans(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w300,
                  color: ThemeColors.getColorTheme(Config.themType)["color7"],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  imageDelete() async {
    Config.genelModal(context, const LoadingModal());
    var data = {
      "user_id": Config.userBilgi.userId,
      "token": Config.userBilgi.token,
      "lang": Config.lang,
    };
    var sonuc = await Httpservices().postMethod("profile/delete-img.php", data);
    var body = json.decode(sonuc);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    if (body["success"]) {
      setState(() {
        themeController.userInfo.first.picture = null;
      });
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
  }

  imagesSelect(ImageSource type) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: type);
      if (pickedFile == null) return;
      _image = File(pickedFile.path);
      // ignore: use_build_context_synchronously
      Config.genelModal(context, const LoadingModal());
      var url = Uri.parse("${Config.siteUrl}profile/change-img.php");
      var request = http.MultipartRequest('post', url);
      request.fields['user_id'] = Config.userBilgi.userId!;
      request.fields['token'] = Config.userBilgi.token!;
      request.fields['lang'] = Config.lang;
      var fileName = pickedFile.path.toString().split('/').last;
      var multipartFile = await http.MultipartFile.fromPath(
        'img',
        _image!.path,
        filename: fileName,
        contentType: MediaType("image", "jpeg"),
      );
      request.files.add(multipartFile);

      var response = await request.send();
      // Navigator.pop(context);
      if (response.statusCode == 200) {
        var responsedata = await http.Response.fromStream(response);
        var body = json.decode(responsedata.body);
        // ignore: use_build_context_synchronously

        if (body["success"]) {
          setState(() {
            themeController.userInfo.first.picture =
                body["result"]["image_url"];
          });
        } else {
          Config.genelModal(
            // ignore: use_build_context_synchronously
            context,
            AlertBox(
                alertIcon:
                    (body["success"]) ? Icons.check : Icons.priority_high,
                alertColor: (body["success"])
                    ? ThemeColors.getColorTheme(
                        Config.themType)["colorsuccess"]!
                    : ThemeColors.getColorTheme(
                        Config.themType)["colordanger"]!,
                title: (body["success"])
                    ? Config.langFulText.general!.success!
                    : Config.langFulText.general!.error!,
                content: body["message"],
                btnText: Config.langFulText.general!.okay!),
          );
        }
      } else {}
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  showBottomMenu(BuildContext context) {
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
                Icons.camera_alt_outlined,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
              ),
              title: Text(
                'Camera',
                style: TextStyle(
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"]!),
              ),
              onTap: () {
                Navigator.pop(context);
                imagesSelect(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.image_outlined,
                color: ThemeColors.getColorTheme(Config.themType)["color10"],
              ),
              title: Text(
                'Gallery',
                style: TextStyle(
                    color:
                        ThemeColors.getColorTheme(Config.themType)["color10"]!),
              ),
              onTap: () {
                // Silme işlemi
                Navigator.pop(context);
                imagesSelect(ImageSource.gallery);
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
