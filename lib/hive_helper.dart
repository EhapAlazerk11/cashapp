import 'package:hive/hive.dart';

import 'contact_response.dart';

class HiveHelper {
  static String keyBoxPhones = "keyBoxPhones";

  static void addContacts(ContactResponse response) {
    Hive.box(keyBoxPhones).put(keyBoxPhones, response.toJson());
  }

  static ContactResponse getContacts() {
    if (Hive.box(keyBoxPhones).isNotEmpty) {
      return ContactResponse.fromJson(Hive.box(keyBoxPhones).get(keyBoxPhones));
    } else {
      return ContactResponse();
    }
  }
}
