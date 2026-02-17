import '../constants/app_strings.dart';

class Validators {
  Validators._();

  static String? cannotBlankValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.cannotBlank;
    } else {
      return null;
    }
  }
}
