class ContactResponse {
  ContactResponse({
      this.contactsModelList,});

  ContactResponse.fromJson(dynamic json) {
    if (json['contactsModelList'] != null) {
      contactsModelList = [];
      json['contactsModelList'].forEach((v) {
        contactsModelList?.add(ContactsModelList.fromJson(v));
      });
    }
  }
  List<ContactsModelList>? contactsModelList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (contactsModelList != null) {
      map['contactsModelList'] = contactsModelList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ContactsModelList {
  ContactsModelList({
      this.name, 
      this.phone,});

  ContactsModelList.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
  }
  String? name;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }

}