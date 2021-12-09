import 'dart:io';

import 'package:cashapp/hive_helper.dart';
import 'package:cashapp/transfer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'contact_response.dart';
import 'custom_dialog.dart';

Future<void> main() async {
  var path = Directory.current.path;
  Hive.init(path);
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(HiveHelper.keyBoxPhones);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.red, width: 1)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.red, width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Color(0xffff9733), width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              )),
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        primaryColor: const Color(0xffff9733),
        fontFamily: "Dubai",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ContactsModelList> mData = [];

  @override
  void initState() {
    super.initState();
      if (HiveHelper.getContacts().contactsModelList != null) {

         mData=HiveHelper.getContacts().contactsModelList!;
      }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (HiveHelper.getContacts().contactsModelList != null) {
  //
  //      mData=HiveHelper.getContacts().contactsModelList!;
  //   }
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // mData=HiveHelper.getContacts().contactsModelList!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashApp'),
      ),
      body: mData.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TransferScreen(mData[index])));
                  },
                  child: Card(
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            mData[index].name!,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => CustomDialog(

              onClick: () {
                setState(() {
                  if (HiveHelper.getContacts().contactsModelList != null) {
                     mData  = HiveHelper.getContacts().contactsModelList!.toList();
                  }
                });
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
