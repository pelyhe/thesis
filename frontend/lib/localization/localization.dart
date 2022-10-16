import 'package:get/get.dart';

class Languages extends Translations {
  /*
  * expected format:
  * '<county_code>':{
        '<key>':'<trasnlation>',
        '<key>':'<trasnlation>'
    }
  * example:
    {
        'ko_KR': {
          'greeting': '안녕하세요',
        },
        'ja_JP': {
          'greeting': 'こんにちは',
        },
        'en_US': {
          'greeting': 'Hello',
        },
      }
  * usage:  'greeting'.tr,  --> returns the translation for the current language
  * set current language:  Get.updateLocale(const Locale('ko', 'KR'))
  */
  @override
  Map<String, Map<String, String>> get keys => {};
}
