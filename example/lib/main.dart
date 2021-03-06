import 'package:flutter/material.dart';
import 'package:ts_text_field/ts_text_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TsTextField Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TsTextField Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "TextField"),
              ),
              TsTextField(
                decoration: InputDecoration(labelText: "TsTextField"),
              ),
              TsTextFormField(
                decoration: InputDecoration(labelText: "TsTextFormField"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
