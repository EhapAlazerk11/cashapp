import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'contact_response.dart';
 import 'hive_helper.dart';

class CustomDialog extends StatelessWidget {
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final Function? onClick;

  CustomDialog({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(
            16.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'NameIsRequired';
                  }
                  if (text.length < 9) {
                    return 'NameIsTooShort';
                  }
                  return null;
                },
                autofocus: false,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'phoneNumber',
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'phoneIsRequired';
                  }
                  if (text.length < 9) {
                    return 'phoneIsTooShort';
                  }
                  return null;
                },
                autofocus: false,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 16,
              ),
              MaterialButton(
                onPressed: () {
                  ContactsModelList model = ContactsModelList(
                      name: _nameController.text,
                      phone: _phoneNumberController.text);

                  List<ContactsModelList> modelsList = [];
                  if (HiveHelper.getContacts().contactsModelList != null) {
                    modelsList
                        .addAll(HiveHelper.getContacts().contactsModelList!);
                  }

                  modelsList.add(model);

                  ContactResponse mContactResponse =
                      ContactResponse(contactsModelList: modelsList);

                  HiveHelper.addContacts(mContactResponse);

                  Navigator.pop(context);
                  onClick!.call();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Theme.of(context).primaryColor,
                child: const Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
