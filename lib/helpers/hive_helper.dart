import 'package:hive/hive.dart';

class HiveHelper {
  static String boxKey = "BoxKey";
  static String idKey = "idKey";
  static String isAdminKey = "isAdmin";
  static String? checkKey = HiveHelper.getId();

  static void setIsAdmin(bool isAdmin) async {
    await Hive.box(boxKey).put(isAdminKey, isAdmin);
  }

  static bool? isAdmin() {
    if (Hive.box(boxKey).containsKey(isAdminKey)) {
      if(Hive.box(boxKey).get(isAdminKey) == null){
        return null;
      }
      return Hive.box(boxKey).get(isAdminKey);
    }
    return null;
  }
  static void removeIsAdmin() async {
    await Hive.box(boxKey).delete(isAdminKey);
  }
  static setId(String token) async {
    await Hive.box(boxKey).put(idKey, token);
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
