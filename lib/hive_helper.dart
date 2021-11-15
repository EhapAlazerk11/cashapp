import 'dart:convert';

import 'package:hive/hive.dart';

import 'contacts_model.dart';

class HiveHelper {
  static String keyBoxPhones = "keyBoxPhones";

  static void addContacts(String models) {
    Hive.box(keyBoxPhones).put(keyBoxPhones, models);
  }

  static List<ContactsModel> getContacts() {
    if (Hive.box(keyBoxPhones).isNotEmpty) {
      return List<ContactsModel>.from(json
          .decode(Hive.box(keyBoxPhones).get(keyBoxPhones))
          .map((model) => ContactsModel.fromJson(model)));
    } else {
      return [];
    }
  }
}
