import 'package:flutter/material.dart';
import 'package:mi_termometro/screens/HomeMain/main_drawer.dart';

class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        drawer: MainDrawer(),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
