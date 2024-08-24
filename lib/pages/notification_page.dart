import 'package:tryt/components/custom_listile.dart';
import 'package:tryt/config/config.dart';
import 'package:tryt/config/themecolors.dart';
import 'package:tryt/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Notificationmodel> bildimler = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    loadPage();
  }

  loadPage() async {
    var bildim = await getNotifications();
    setState(() {
      loading = false;
      bildimler = bildim;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              title: Text(
                Config.langFulText.notifications!.pageTitle!,
                style: GoogleFonts.mukta(
                  fontSize: 32,
                  color: ThemeColors.getColorTheme(Config.themType)["color10"],
                  letterSpacing: -0.8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ];
        },
        body: (loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (bildimler.isNotEmpty)
                ? ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 0,
                      right: 0,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, right: 0, left: 0),
                        child: CustomListile(
                          userImg: bildimler[index].user!.img!,
                          userName: bildimler[index].user!.username!,
                          notificationDate: bildimler[index].date!,
                          notificationText: bildimler[index].text!,
                        ),
                      );
                    },
                    itemCount: bildimler.length,
                  )
                : Center(
                    child: Text(
                      Config.langFulText.notifications!.noNotification!,
                      style: GoogleFonts.firaSans(
                        fontSize: 16,
                        height: 1.26,
                        color: ThemeColors.getColorTheme(
                            Config.themType)["color10"],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
      ),
    );
  }
}
