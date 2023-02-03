import 'package:hive/hive.dart';

import '../enums/sex.dart';

part 'user_settings.g.dart';

@HiveType(typeId: 0)
class UserSettingsModel {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final Sex sex;
  @HiveField(2)
  final List<String> color;
  @HiveField(3)
  final bool darkTheme;
  @HiveField(4)
  final bool light;

  UserSettingsModel(
      {required this.userName,
      required this.sex,
      required this.color,
      required this.darkTheme,
      required this.light});

  @override
  String toString() {
    return 'UserSettingsModel{userName: '
        '$userName,'
        ' sex: $sex, color: $color, '
        'darkTheme: $darkTheme,'
        ' light: $light}';
  }
}
