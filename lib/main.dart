import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:storage/enums/colors.dart';
import 'package:storage/enums/sex.dart';
import 'package:storage/files_page.dart';
import 'package:storage/hive_page.dart';
import 'package:storage/service/shared_pref_service.dart';

import 'model/user_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserSettingsModelAdapter());
  Hive.registerAdapter(SexAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final _userName = TextEditingController();
  var _userSex = Sex.FEMALE;
  var _customColors = <String>[];
  bool _darkTheme = false;
  bool _lights = false;
  final service = SharedPrefService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _userName,
                    decoration:
                        const InputDecoration(label: Text("Enter name")),
                  ),
                ),
                radioListTile(
                    title: describeEnum(Sex.FEMALE).toString(),
                    sex: Sex.FEMALE),
                radioListTile(
                    title: describeEnum(Sex.MALE).toString(), sex: Sex.MALE),
                checkBoxTile(
                    title: "BLUE",
                    color: CustomColors.BLUE,
                    colors: _customColors),
                checkBoxTile(
                    title: "RED",
                    color: CustomColors.RED,
                    colors: _customColors),
                checkBoxTile(
                    title: "WHITE",
                    color: CustomColors.WHITE,
                    colors: _customColors),
                switchTile(
                    title: 'Dark Theme', icon: Icons.access_alarm_rounded),
                SwitchListTile(
                  title: const Text('Lights'),
                  value: _lights,
                  onChanged: (bool value) {
                    setState(() {
                      _lights = value;
                    });
                  },
                  secondary: const Icon(Icons.lightbulb_outline),
                ),
                ElevatedButton(
                    onPressed: () {
                      final model = UserSettingsModel(
                          sex: _userSex,
                          color: _customColors,
                          darkTheme: _darkTheme,
                          light: _lights,
                          userName: _userName.text);

                      service.saveUserSettings(model);
                      setState(() {});
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FilesPage()));
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HivePage()));
                    },
                    child: const Text('Go to HivePage'))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget switchTile({required String title, required IconData icon}) {
    return SwitchListTile(
        activeTrackColor: Colors.deepPurple,
        activeColor: Colors.deepPurple,
        title: Text(title),
        secondary: Icon(icon),
        value: _darkTheme,
        onChanged: (bool value) {
          setState(() {
            _darkTheme = value;
          });
        });
  }

  Widget checkBoxTile(
      {required String title,
      required CustomColors color,
      required List colors}) {
    return CheckboxListTile(
        title: Text(title),
        value: colors.contains(describeEnum(color)),
        onChanged: (bool? state) {
          setState(() {
            if (state == true) {
              _customColors.add(describeEnum(color));
            } else {
              _customColors.remove(describeEnum(color));
            }
            debugPrint(colors.toString());
          });
        });
  }

  Widget radioListTile({
    required String title,
    required Sex sex,
  }) {
    return RadioListTile(
        activeColor: Colors.red,
        contentPadding: const EdgeInsets.all(8),
        title: Text(title),
        value: sex,
        groupValue: _userSex,
        onChanged: (Sex? value) {
          setState(() {
            _userSex = value!;
            debugPrint("selected");
          });
        });
  }

  void getDataFromSharedPref() async {
    final model = await service.getUserSettings();

    setState(() {
      _userName.text = model.userName;
      _userSex = model.sex;
      _darkTheme = model.darkTheme;
      _customColors = model.color;
      _lights = model.light;
    });
  }
}
