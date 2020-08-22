import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_termometro/model/formu.dart';
import 'package:mi_termometro/model/genero.dart';
import 'package:mi_termometro/screens/Form/quiz.dart';

class ContactInfo extends StatefulWidget {
  final Formu formu;
  ContactInfo({Key key, @required this.formu});
  @override
  _ContactInfoState createState() => _ContactInfoState(formu: formu);
}

class _ContactInfoState extends State<ContactInfo> {
  //Obtener datos formulario
  final Formu formu;
  _ContactInfoState({Key key, @required this.formu});

  //Seelects
  List<Genero> _genero = Genero.getGenero();
  List<DropdownMenuItem<Genero>> _dropdownGeneros;
  Genero _SelectedGenero;

  List<DropdownMenuItem<Genero>> buildDropdownGeneros(List generos) {
    List<DropdownMenuItem<Genero>> items = List();
    for (Genero genero in generos) {
      items.add(DropdownMenuItem(
        value: genero,
        child: Text(genero.name),
      ));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _dropdownGeneros = buildDropdownGeneros(_genero);
    _SelectedGenero = _dropdownGeneros[0].value;
  }

  onChangeDropdownItem(Genero selectedGenero) {
    setState(() {
      _SelectedGenero = selectedGenero;
    });
  }

  //Text inputs
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _mailController = new TextEditingController();
  TextEditingController _edadController = new TextEditingController();
  TextEditingController _estratoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = formu.nombre;
    _mailController.text = formu.correo;
    _edadController.text = formu.edad;
    _estratoController.text = formu.estrato;

    return Scaffold(
        appBar: AppBar(
          title: Text('Información de contacto'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15),
              Text("Nombre",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 10),
                child: TextField(
                  controller: _nameController,
                  autofocus: true,
                ),
              ),
              Text("Correo",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 10),
                child: TextField(
                  controller: _mailController,
                  autofocus: false,
                ),
              ),
              Text("Genero",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              SizedBox(
                height: 7,
              ),
              DropdownButton(
                value: _SelectedGenero,
                items: _dropdownGeneros,
                onChanged: onChangeDropdownItem,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Seleccionado: ${_SelectedGenero.name}'),
              Text("Edad", style: TextStyle(fontSize: 18, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _edadController,
                  autofocus: false,
                ),
              ),
              Text("Estrato",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _estratoController,
                  autofocus: false,
                ),
              ),
              RaisedButton(
                  child: Text("Continuar", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    formu.nombre = _nameController.text;
                    formu.correo = _mailController.text;
                    formu.genero = _SelectedGenero.name;
                    formu.edad = _edadController.text;
                    formu.estrato = _estratoController.text;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Quiz(
                                  formu: formu,
                                )));
                  })
            ],
          )),
        ));
  }
}
