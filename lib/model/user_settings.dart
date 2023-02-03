import '../enums/sex.dart';

class UserSettingsModel {
  final String userName;
  final Sex sex;
  final List<String> color;
  final bool darkTheme;
  final bool light;

  UserSettingsModel(
      {required this.userName,
      required this.sex,
      required this.color,
      required this.darkTheme,
      required this.light});

  @override
  String toString() {
    return 'UserSettingsModel{userName: $userName, sex: $sex, color: $color, darkTheme: $darkTheme, light: $light}';
  }
}
