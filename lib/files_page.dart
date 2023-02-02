import 'package:flutter/material.dart';
import 'package:storage/service/path_provider.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({Key? key}) : super(key: key);

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  final model = ExampleWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Work with files'), centerTitle: true),
      body: Center(
        child: ExampleWidgetModelProvider(
          model: model,
          child: Column(
            children: const [
              _CreateFileButton(),
              _ReadFileButton()
              //  _createFile(),
            ],
          ),
        ),
      ),
    );
  }

// ElevatedButton _readFile() {
//   return ElevatedButton(
//       style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
//       onPressed: ExampleWidgetModelProvider
//       .read(context)
//       ?.model
//       .getFile, child: Text("Get file",));
// }

}

class _CreateFileButton extends StatelessWidget {
  const _CreateFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ExampleWidgetModelProvider.read(context)?.model.createFile,
      child: const Text('Создать файл'),
    );
  }
}

class _ReadFileButton extends StatelessWidget {
  const _ReadFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ExampleWidgetModelProvider.read(context)?.model.readFile,
      child: const Text('Прочитать файл'),
    );
  }
}
