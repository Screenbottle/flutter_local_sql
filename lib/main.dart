import 'package:flutter/material.dart';
import 'package:flutter_local_sql/database_service.dart';
import 'package:flutter_local_sql/model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final DbService dbService = DbService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My messages',
      home: MyCustomForm(dbService),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final DbService dbService;
  const MyCustomForm(this.dbService, {Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController textTextcontroller = TextEditingController();
  var _list = [];
  @override
  void dispose() {
    titleTextController.dispose();
    textTextcontroller.dispose();
    super.dispose();
  }

  getMessages() async {
    List<Message> newList = await widget.dbService.getAllMessagesFromDb();
    List<String> _newList = newList
        .map((messages) => '${messages.title} || ${messages.text}')
        .toList();

    setState(() {
      _list = _newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messageboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: titleTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: textTextcontroller,
            ),
          ),
          TextButton(
            onPressed: () {
              widget.dbService.putMessagesInDb(
                Message(
                    title: titleTextController.text,
                    text: textTextcontroller.text),
              );
            },
            child: Text('save message'),
          ),
          TextButton(
            onPressed: () {
              getMessages();
            },
            child: Text('Get all messages'),
          ),
          for (String item in _list) Text(item),
        ],
      ),
    );
  }
}