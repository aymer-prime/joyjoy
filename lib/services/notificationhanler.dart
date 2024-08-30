import 'package:tryt/config/config.dart';
import 'package:tryt/pages/notification_page.dart';
import 'package:tryt/services/prefservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationHandler {
  //RemoteMessage? messaging =await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final NotificationHandler _singleton = NotificationHandler._singleton;
  // final PrefService pref = PrefService();
  late BuildContext myContext;
  insertlistin(BuildContext context) async {
    myContext = context;
    permission();
    getmessange();
    strintoken();
    submessagelist([]);
  }

  strintoken() async {
    var token = await FirebaseMessaging.instance.getToken();
    await PrefService().setString("fcm", token ?? "");
    print("FCM token $token");
    print("user token ${Config.userBilgi.token}}");
  }

  submessagelist(List tipler) async {
    for (int i = 0; i < tipler.length; i++) {
      int durumu = await PrefService().getInt(tipler[i].toString());
      if (durumu == 0) {
        await FirebaseMessaging.instance.subscribeToTopic(tipler[i].toString());
        await PrefService().setInt(tipler[i], 1);
      } else {}
    }
  }

  submessage(String tip) async {
    await PrefService().setInt(tip, 1);
    await FirebaseMessaging.instance.subscribeToTopic(tip);
  }

  submessagedelete(String tip) async {
    await PrefService().setInt(tip, 2);
    await FirebaseMessaging.instance.unsubscribeFromTopic(tip);
  }

  permission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }

  getmessange() async {
    print("geldi");
    //uygulama açıkken gelen mesaj
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        Get.defaultDialog(
          title: "Mesaj Başlık",
          middleText: "Mesaj Açıklama",
          textConfirm: "Tamam",
          textCancel: "İptal",
          onConfirm: () {
            // Tamam butonuna tıklandığında yapılacak işlem
            Get.off(const NotificationPage());
            Get.back(); // Diyaloğu kapatır
          },
          onCancel: () {
            // İptal butonuna tıklandığında yapılacak işlem
            Get.back(); // Diyaloğu kapatır
          },
        );
        int a = 0;
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null && a == 0) {}
      },
    );

    //ugulama arkaplanda veya kapalıyken gelecek mesaj
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("Kapalı");
      Get.off(const NotificationPage());

      // showNotification(
      //     message.data["title"].toString(),
      //     message.data["body"].toString(),
      //     message.data["link"].toString(),
      //     message.data["resim"].toString());
    });
    //uygulama açıldığında mesaj var mı diye baklıyor  varsa yönlenecek
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Get.defaultDialog(
          title: "açıldı",
          middleText: "Bu bir GetX alert diyaloğudur.",
          textConfirm: "Tamam",
          textCancel: "İptal",
          onConfirm: () {
            // Tamam butonuna tıklandığında yapılacak işlem
            Get.back(); // Diyaloğu kapatır
          },
          onCancel: () {
            // İptal butonuna tıklandığında yapılacak işlem
            Get.back(); // Diyaloğu kapatır
          },
        );
        // showNotification(
        //     message.data["title"].toString(),
        //     message.data["body"].toString(),
        //     message.data["link"].toString(),
        //     message.data["resim"].toString());
      }
    });
    //arkaplanda çalıldığında
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
