import 'package:flutter/material.dart';
import 'package:storage/service/hive_service.dart';

class HivePage extends StatefulWidget {
  const HivePage({Key? key}) : super(key: key);

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  final model = HiveModelService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Hive")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => model.putUser(),
                child: const Text("Get value from Hive"))
          ],
        ),
      ),
    );
  }
}
