import 'package:eventsmanager/core/constants/apptheme.dart';
import 'package:eventsmanager/core/services/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLocalController extends GetxController {
  late Locale language;
  SharedprefService service = Get.find();

  bool get isEnglish => language.languageCode == 'en';

  void changeLocal(String langCode) {
    Locale locale = Locale(langCode);
    service.stringSetter(key: "lang",value: langCode);
    ThemeData newTheme =
        (langCode == "ar") ? getThemeArabic() : getThemeEnglish();
    Get.changeTheme(newTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = service.stringGetter(key: "lang");
    if (sharedPrefLang == "en") {
      language = Locale("en");
    } else if (sharedPrefLang == "ar") {
      language = Locale("ar");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
