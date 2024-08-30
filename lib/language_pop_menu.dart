import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'config/config.dart';
import 'config/themecolors.dart';
import 'models/languages_model.dart';
import 'services/prefservice.dart';
import '../models/lang_string_model.dart' as lang;

class LanguagePopMenu extends StatefulWidget {
  LanguagePopMenu({super.key});
  @override
  State<LanguagePopMenu> createState() => _LanguagePopMenuState();
}

class _LanguagePopMenuState extends State<LanguagePopMenu> {
  String _selectedLanguage = Config.lang;
  List<Languagesmodel> _languagesList = [];

  Future<void> getLang() async {
    _languagesList = await getLanguagesList();
  }
  @override
  void initState() {
    getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 5,
      right: 10,
      child: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: ThemeColors.getColorTheme(Config.themType)["colorprimary"],
        ),
        child: PopupMenuButton<String>(
          initialValue: _selectedLanguage,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 40,
              height: 40,
              color: Colors.black.withOpacity(0.9),
              padding: const EdgeInsets.all(8),
              child: const Icon(FontAwesome5.globe, size: 16),
            ),
          ),
          onSelected: (value) async {
            _selectedLanguage = value;
            await PrefService().setString("systhemLang", _selectedLanguage);
            var data = await lang.getLangFulTextApi(_selectedLanguage);
            setState(() {
              Config.lang = _selectedLanguage;
              Config.langFulText = data;
            });
            Phoenix.rebirth(context);
          },
          itemBuilder: (BuildContext context) => _buildMenuItems(),
        ),
      )
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems() {
    return _languagesList.map((Languagesmodel language) {
      return PopupMenuItem<String>(
        value: language.shortName,
        child: Row(
          children: [
            if (_selectedLanguage == language.shortName)
              const Icon(
                Icons.check,
                color: Colors.white,
              ),
            SizedBox(width: 8),
            Text(
              language.name ?? " ",
              style: TextStyle(
                fontSize: 15,
                color: _selectedLanguage == language.shortName ? Colors.white : ThemeColors.getColorTheme(Config.themType)["color5"],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
