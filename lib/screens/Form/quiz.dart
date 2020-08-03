import 'package:flutter/material.dart';
import 'package:mi_termometro/model/formu.dart';

class Quiz extends StatefulWidget {
  final Formu formu;
  Quiz({Key key, @required this.formu}) : super(key: key);

  @override
  _QuizState createState() => _QuizState(formu: formu);
}

class _QuizState extends State<Quiz> {
  final Formu formu;
  _QuizState({Key key, @required this.formu});

  String preg9;
  String preg10;

  @override
  void initState() {
    super.initState();
    preg9 = null;
    preg10 = null;
  }

  setPreg9(String val) {
    setState(() {
      preg9 = val;
    });
  }

  setPreg10(String val) {
    setState(() {
      preg10 = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Encuesta"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("¿Ha viajado a otros países en los últimos 14 días?"),
                Radio(
                    value: "Si",
                    groupValue: preg9,
                    onChanged: (val) {
                      setPreg9(val);
                    }),
                Radio(
                    value: "No",
                    groupValue: preg9,
                    onChanged: (val) {
                      setPreg9(val);
                    })
              ],
            )
          ],
        ));
  }
}
