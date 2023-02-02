import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ExampleWidgetModel extends ChangeNotifier {
  Future<File> getFile() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/my_file';
    final file = File(filePath);
    return file;
  }

  readFile() async {
    final file = await getFile();
    if (await file.exists()) {
     final txt =  await file.readAsString();
     debugPrint(txt);
    } else {
      throw IOException;
    }
  }

  void createFile() async {
    final file = await getFile();
    try {
      await file.writeAsString('Ну ты козел/works!!!');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class ExampleWidgetModelProvider extends InheritedNotifier {
  final ExampleWidgetModel model;

  const ExampleWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ExampleWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ExampleWidgetModelProvider>();
  }

  static ExampleWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleWidgetModelProvider>()
        ?.widget;
    return widget is ExampleWidgetModelProvider ? widget : null;
  }
}
