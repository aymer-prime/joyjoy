import 'package:tryt/config/config.dart';
import 'package:tryt/models/chat_detail_model.dart';
import 'package:tryt/models/chat_liste_model.dart';
import 'package:tryt/models/feeed_model.dart';
import 'package:tryt/models/models_model.dart';
import 'package:tryt/models/myuserinfo_model.dart';
import 'package:tryt/models/story_model.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxList<Myuserinfomodel> userInfo = RxList<Myuserinfomodel>();
  RxList<Feedmodel> feedmodel = RxList<Feedmodel>();
  RxList<Storymodel> stoyrlist = RxList<Storymodel>();
  RxList<Chatlistemodel> chatListe = RxList<Chatlistemodel>();
  RxList<Modelsmodel> suggestionlist = RxList<Modelsmodel>();
  RxList<Chatdetailmodel> chatDetayListe = RxList<Chatdetailmodel>();

  RxString theme = Config.themType.obs;
  RxString themeLang = Config.lang.obs;

  RxInt activeIndex = 0.obs;
  var clickHistory = <int>[].obs;

  getFeedAdd(int page) async {
    var data = await getFeedListe(page);
    feedmodel.addAll(data);
    print('feed Date: $data');
    update();
  }

  getStoryAdd() async {
    var storyData = await getStoryListe();
    stoyrlist.value = storyData;
    update();
  }

  getChatListeAdd(int page) async {
    var chatliste = await getChatListe(page);
    chatListe.value = chatliste;
    update();
  }

  getSuggestionAdd() async {
    var suggestion = await getGenderCatList(1, "1", "1");
    suggestionlist.value = suggestion;
    update();
  }

  getChatDetayAdd(String chatId, int page) async {
    var chatdetayListe = await getChatDetailListe(chatId, page);
    chatDetayListe.add(chatdetayListe);
    update();
  }

  getChatDetayNextAdd(String chatId, int page) async {
    var chatdetayListe = await getChatDetailNextListe(chatId, page);
    chatDetayListe.first.chatHistory!.addAll(chatdetayListe);
    chatDetayListe.refresh();
    update();
  }

  getChatDetayAddData(ChatHistory datam) async {
    chatDetayListe.first.chatHistory!.insert(0, datam);
    update();
  }

  getMyuser() async {
    var data = await getUserInfo();
    if (userInfo.isNotEmpty) {
      userInfo[0] = data;
    } else {
      userInfo.add(data);
    }
    update();
  }

  void changeTheme(String newTheme) {
    theme.value = newTheme;
    Config.themType = newTheme;
    update();
  }
}
