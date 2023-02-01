import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/enums/colors.dart';
import 'package:storage/enums/sex.dart';

const userNameKey = 'usernameKey';
const radioListTileKey = 'radioListTileKey';
const colorsKey = 'colorsKey';
const switchListTileKey = 'switchListTileKey';

void main() {
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
  var userNameTextController = TextEditingController();
  var radioListTileValue = Sex.FEMALE;
  var customColors = <String>[];
  bool switchTileState = false;
  bool _lights = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserSettings();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: userNameTextController,
                  decoration: const InputDecoration(label: Text("Enter name")),
                ),
              ),
              radioListTile(
                  title: describeEnum(Sex.FEMALE).toString(), sex: Sex.FEMALE),
              radioListTile(
                  title: describeEnum(Sex.MALE).toString(), sex: Sex.MALE),
              checkBoxTile(
                  title: "BLUE",
                  color: CustomColors.BLUE,
                  colors: customColors),
              checkBoxTile(
                  title: "RED", color: CustomColors.RED, colors: customColors),
              checkBoxTile(
                  title: "WHITE",
                  color: CustomColors.WHITE,
                  colors: customColors),
              switchTile(title: 'Dark Theme', icon: Icons.access_alarm_rounded),
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
                  onPressed: () => saveUserSettings(),
                  child: const Text('Save'))
            ])
          ],
        ),
      ),
    );
  }

  void saveUserSettings() async {
    final sharedPref = await SharedPreferences.getInstance();
    final c = sharedPref.setString(userNameKey, userNameTextController.text);
    final d = sharedPref.setInt(radioListTileKey, radioListTileValue.index);
    debugPrint(radioListTileValue.index.toString());

    final g = sharedPref.setBool(switchListTileKey, switchTileState);
    final a = sharedPref.setStringList(colorsKey, customColors);
    debugPrint('${a.toString()} + $c + $d + $g');
  }

  Widget switchTile({required String title, required IconData icon}) {
    return SwitchListTile(
        activeTrackColor: Colors.deepPurple,
        activeColor: Colors.deepPurple,
        title: Text(title),
        secondary: Icon(icon),
        value: switchTileState,
        onChanged: (bool value) {
          setState(() {
            switchTileState = value;
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
              customColors.add(describeEnum(color));
            } else {
              customColors.remove(describeEnum(color));
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
        groupValue: radioListTileValue,
        onChanged: (Sex? value) {
          setState(() {
            radioListTileValue = value!;
            debugPrint("selected");
          });
        });
  }

  void getUserSettings() async {
    final sharedPref = await SharedPreferences.getInstance();
    userNameTextController.text = sharedPref.getString(userNameKey) ?? '';
    radioListTileValue = Sex.values[sharedPref.getInt(radioListTileKey) ?? 0];
    customColors = sharedPref.getStringList(colorsKey) ?? [];
    switchTileState = sharedPref.getBool(switchListTileKey) ?? false;
    setState(() {});
  }
}
