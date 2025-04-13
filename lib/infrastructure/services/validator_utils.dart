// ignore_for_file: constant_identifier_names
import 'app_helpers.dart';
import 'tr_keys.dart';

abstract class ValidatorUtils {
  static String? validateEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return AppHelpers.getTranslation(TrKeys.fieldRequired);
    } else {
      return null;
    }
  }
}


