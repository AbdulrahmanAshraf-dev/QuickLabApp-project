import 'package:hive/hive.dart';

class HiveHelper {
  static String boxKey = "BoxKey";
  static String idKey = "idKey";
  static String checkKey = "check";

  static setId(String token) async {
    await Hive.box(boxKey).put(idKey, token);
  }

  static checkLogin(bool? check) async {
    await Hive.box(boxKey).put(checkKey, check);
  } static getCheckLogin() async {
    await Hive.box(boxKey).get(checkKey);
  }

  static removeId() async {
    await Hive.box(boxKey).delete(idKey);
  }

  static bool isLoggedIn() {
    if (Hive.box(boxKey).containsKey(idKey)) {
      return true;
    }
    return false;
  }

  static String? getId() {
    if (Hive.box(boxKey).containsKey(idKey)) {
      return Hive.box(boxKey).get(idKey);
    }
    return null;
  }
}
