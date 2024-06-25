import 'package:get/get.dart';

import 'ar.dart';
import 'en.dart';

class LanguageTranslation extends Translations {
  Map<String, String> en = coreEn;
  Map<String, String> ar = coreAr;

  LanguageTranslation();

  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'ar': ar};
}
