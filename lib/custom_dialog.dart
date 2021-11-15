import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'contacts_model.dart';
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
            mainAxisSize: MainAxisSize.min, // To make the card compact
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
                onPressed: ()  {
                  // var n = Hive.box("box").get("box");
                  // Hive.box("box").put("box", n++);
                  ContactsModel model = ContactsModel(
                      _nameController.text, _phoneNumberController.text);

                  List<ContactsModel> modelsList = [];
                  modelsList.addAll(HiveHelper.getContacts());

                  modelsList.add(model);

                  HiveHelper.addContacts(jsonEncode(modelsList));

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
