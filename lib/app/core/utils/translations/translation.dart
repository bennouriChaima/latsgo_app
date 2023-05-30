import 'package:get/get.dart';
import 'package:urban_app/app/core/utils/translations/translations_assets_reader.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': TranslationsAssetsReader.en!,
        'fr': TranslationsAssetsReader.fr!,
      };
}
