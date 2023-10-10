
import 'package:getx_mvvm/services/app_translator.dart';

extension AppTrans on String {
  Future<String> toLocalize() async {
    return await AppTranslator.instance.translate(this);
  }
}