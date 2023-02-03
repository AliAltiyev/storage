import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:storage/model/user_settings.dart';

import '../enums/sex.dart';

class HiveModelService extends ChangeNotifier {
  putUser() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserSettingsModelTypeAdapter());
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

class UserSettingsModelTypeAdapter extends TypeAdapter<UserSettingsModel> {
  @override
  UserSettingsModel read(BinaryReader reader) {
    final colors = reader.readStringList();
    final userName = reader.readString();
    final darkTheme = reader.readBool();
    final light = reader.readBool();

    return UserSettingsModel(
        userName: userName,
        sex: Sex.MALE,
        color: colors,
        darkTheme: darkTheme,
        light: light);
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, UserSettingsModel obj) {
    writer.write(obj.light);
    writer.write(obj.color);
    writer.write(describeEnum(obj.sex));
    writer.write(obj.userName);
    writer.write(obj.darkTheme);
  }
}
