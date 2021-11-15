import 'package:hive/hive.dart';
part 'contacts_model.g.dart';
@HiveType(typeId:0)
class ContactsModel extends HiveObject {
 @HiveField(0)
 String? name;
 @HiveField(1)
 String? phone;

 ContactsModel.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  phone = json['phone'];
 }
 ContactsModel(this.name, this.phone);



}
