import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:storage/model/user_settings.dart';

import '../enums/sex.dart';

class HiveModelService extends ChangeNotifier {
  putUser() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserSettingsModelAdapter());

      //Hive.registerAdapter();
    }
    final hive = await Hive.openBox('users');

    final user = UserSettingsModel(
        userName: "Женя",
        sex: Sex.FEMALE,
        color: ["Yellow", "Red", "Green", "Pink"],
        darkTheme: true,
        light: false);

    hive.put('userSet', user);
    debugPrint(hive.values.toString());
  }
}
