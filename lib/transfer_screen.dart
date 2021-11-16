import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

import 'contact_response.dart';

class TransferScreen extends StatelessWidget {
  ContactsModelList mData;
  final _amountController = TextEditingController();

  TransferScreen(this.mData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransferScreen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ListView(shrinkWrap: true, children: [
            Row(
              children: [
                Text(
                  'name',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    mData.name!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  'phone',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    mData.phone!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'amount',
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (text) {
                if (text!.isEmpty) {
                  return 'amountIsRequired';
                }
                return null;
              },
              autofocus: false,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(height: 50,
              onPressed: () async {
                UssdAdvanced.sendUssd(
                    code: "*9*7*${mData.phone}*${_amountController.text}#",
                    subscriptionId: 1);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Theme.of(context).primaryColor,
              child: const Text(
                'Transfer',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 16),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
