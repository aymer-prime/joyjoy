import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';

class BuycoinModal extends StatefulWidget {
  const BuycoinModal({super.key});

  @override
  State<BuycoinModal> createState() => _BuycoinModalState();
}

class _BuycoinModalState extends State<BuycoinModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://cizimmedya.com/tryt/files/gender/1/1/women-500-orj.jpg?v=1.2.004021720802702"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 75, left: 32, right: 32, bottom: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.9],
                  colors: [
                    Color.fromARGB(1, 0, 0, 0),
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 0, 0, 0),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/logo-white.png",
                    width: 150,
                  ),
                  Row(
                    children: [
                      Icon(
                        LineariconsFree.checkmark_cicle,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["colorprimary"],
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        " Karşılıklı sesli sohbet edebilme",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        LineariconsFree.checkmark_cicle,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["colorprimary"],
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        " Fotoğraf gönderme, Fotoğraf yorumlatma ve Fotoğraf isteme",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        LineariconsFree.checkmark_cicle,
                        color: ThemeColors.getColorTheme(Config.themType)[""],
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        " Akış ekranındaki paylaşımları görme, beğenme, yorumlama",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
