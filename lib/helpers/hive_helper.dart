import 'package:hive/hive.dart';

class HiveHelper{
  static String boxKey = "BoxKey";
  static String idKey = "idKey";


  static setId(String token) async {
    await Hive.box(boxKey).put(idKey, token);
  }

  static bool isLoggedIn() {
    if (Hive.box(boxKey).containsKey(idKey)) {
      return true;
    }
    return false;
  }

  static String? getId() {
    if(Hive.box(boxKey).containsKey(idKey)){
      return Hive.box(boxKey).get(idKey);
    }
    return null;
  }
}