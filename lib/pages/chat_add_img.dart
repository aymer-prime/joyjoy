import 'dart:io';

import 'package:tryt/components/app_bar_back.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/file_model.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ChatAddImg extends StatefulWidget {
  final ScrollController scrollController;
  const ChatAddImg({super.key, required this.scrollController});

  @override
  State<ChatAddImg> createState() => _ChatAddImgState();
}

class _ChatAddImgState extends State<ChatAddImg> {
  String image = "";

  List<FileModel> filelist = [];
  bool loadingImage = true;
  @override
  void initState() {
    super.initState();
    _pickImages();
  }

  _pickImages() async {
    // filelist = [];
    // // var imagePath = await StoragePath.imagesPath;
    // // var images = jsonDecode(imagePath!) as List;
    // // images.map((e) {
    // //   e["files"].forEach((element) {
    // //     filelist.add(FileModel(path: element.toString(), duration: null));
    // //   });
    // }).toList();
    //
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        backgroundColor: ThemeColors.getColorTheme(Config.themType)["color1"],
        leading: const AppBarBack(
          leftPadding: 0,
        ),
        title: Text(
          "Fotoğraf Gönder",
          style: GoogleFonts.firaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ThemeColors.getColorTheme(Config.themType)["color10"],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(15),
                controller: widget.scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: filelist.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context,
                              {"resimdata": filelist[index].path.toString()});
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            width: double.infinity,
                            height: double.infinity,
                            File(filelist[index].path.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
