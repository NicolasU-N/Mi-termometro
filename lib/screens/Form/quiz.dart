import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mi_termometro/model/departamentos.dart';
import 'package:mi_termometro/model/formu.dart';
import 'package:mi_termometro/model/huilamuni.dart';
import 'package:mi_termometro/screens/HomeMain/userscreen.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:group_radio_button/group_radio_button.dart';

class Quiz extends StatefulWidget {
  Formu formu;
  Quiz({Key key, @required this.formu}) : super(key: key);

  @override
  _QuizState createState() => _QuizState(formu: formu);
}

class _QuizState extends State<Quiz> {
  Formu formu;
  _QuizState({Key key, @required this.formu});

  //RADIOS
  String preg10;
  String preg11;

  //Seelects
  List<Departamentos> _departamentos = Departamentos.getDepartamentos();
  List<DropdownMenuItem<Departamentos>> _dropdownDepartamentos;
  Departamentos _SelectedDepartamentos;

  List<Municipios> _municipios = Municipios.getMunicipios();
  List<DropdownMenuItem<Municipios>> _dropdownMunicipios;
  Municipios _SelectedMunicipios;

  List<DropdownMenuItem<Departamentos>> buildDropdownDepartamentos(
      List departamentos) {
    List<DropdownMenuItem<Departamentos>> items = List();
    for (Departamentos departamento in departamentos) {
      items.add(DropdownMenuItem(
        value: departamento,
        child: Text(departamento.name),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<Municipios>> buildDropdownMunicipios(List municipios) {
    List<DropdownMenuItem<Municipios>> items = List();
    for (Municipios municipio in municipios) {
      items.add(DropdownMenuItem(
        value: municipio,
        child: Text(municipio.name),
      ));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _dropdownDepartamentos = buildDropdownDepartamentos(_departamentos);
    _dropdownMunicipios = buildDropdownMunicipios(_municipios);
    _SelectedDepartamentos = _dropdownDepartamentos[33].value;
    _SelectedMunicipios = _dropdownMunicipios[37].value;
    preg10 = null;
    preg11 = null;
  }

  //RADIOS

  setPreg10(String value) {
    setState(() {
      preg10 = value;
    });
  }

  setPreg11(String value) {
    setState(() {
      preg11 = value;
    });
  }

  //SELECTS
  onChangeDropdownItemD(Departamentos selectedDepartamentos) {
    setState(() {
      _SelectedDepartamentos = selectedDepartamentos; //PREG12
    });
  }

  onChangeDropdownItemM(Municipios selectedMunicipios) {
    setState(() {
      _SelectedMunicipios = selectedMunicipios; //PREG14
    });
  }

  TextEditingController _fechaController = new TextEditingController();

  List<String> allItemList = [
    'Fiebre cuantificada mayor o igual a 38°C',
    'Tos',
    'Dolor de garganta',
    'Dificultad para respirar',
    'Fatiga / sensación de cansancio',
    'Ninguno',
  ];

  List<String> allItemList1 = [
    'Enfermedad pulmonar Obstructiva Crónica con requerimiento de Oxigeno',
    'Enfermedad pulmonar Obstructiva Crónica sin requerimiento de Oxigeno',
    'Asma',
    'Diabetes',
    'Hipertensión',
    'Enfermedades autoinmunes',
    'Cáncer / VIH',
    'Tuberculosis',
    'Ninguno',
  ];

  static List<String> checkedItemList = ["Ninguno"];

  List<String> selectedItemList = checkedItemList ?? [];

  static List<String> checkedItemList1 = ["Ninguno"];

  List<String> selectedItemList1 = checkedItemList1 ?? [];

  @override
  Widget build(BuildContext context) {
    _fechaController.text = formu.preg13;
    return Scaffold(
        appBar: AppBar(
          title: Text("Encuesta"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "¿Ha viajado a algún DEPARTAMENTO de colombia en los últimos 14 días?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    height: 7,
                  ),
                  DropdownButton(
                    value: _SelectedDepartamentos,
                    isExpanded: true,
                    items: _dropdownDepartamentos,
                    onChanged: onChangeDropdownItemD,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Seleccionado: ${_SelectedDepartamentos.name}'),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "¿Ha viajado a algún MUNICIPIO de colombia en los últimos 14 días?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  SizedBox(
                    height: 7,
                  ),
                  DropdownButton(
                    value: _SelectedMunicipios,
                    items: _dropdownMunicipios,
                    onChanged: onChangeDropdownItemM,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Seleccionado: ${_SelectedMunicipios.name}'),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("¿Ha viajado a otros paises en los últimos 14 días?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  RadioButton(
                      description: "Si",
                      value: "Si",
                      groupValue: preg10,
                      onChanged: (value) {
                        setPreg10(value);
                      }),
                  RadioButton(
                      description: "No",
                      value: "No",
                      groupValue: preg10,
                      onChanged: (value) {
                        setPreg10(value);
                      }),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "¿Ha tenido contacto con personas que hayan viajado a otros paises en los últimos 14 días?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  RadioButton(
                      description: "Si",
                      value: "Si",
                      groupValue: preg11,
                      onChanged: (value) {
                        setPreg11(value);
                      }),
                  RadioButton(
                      description: "No",
                      value: "No",
                      groupValue: preg11,
                      onChanged: (value) {
                        setPreg11(value);
                      }),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "¿Marque si ha presentado alguno de los sintomas que se detallan a continuación en los últimos 14 días?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  GroupedCheckbox(
                    wrapSpacing: 10.0,
                    wrapRunSpacing: 15.0,
                    wrapRunAlignment: WrapAlignment.center,
                    wrapVerticalDirection: VerticalDirection.down,
                    wrapAlignment: WrapAlignment.center,
                    itemList: allItemList,
                    checkedItemList: checkedItemList,
                    onChanged: (itemList) {
                      setState(() {
                        selectedItemList = itemList;
                        print('SELECTED ITEM LIST $itemList');
                      });
                    },
                    orientation: CheckboxOrientation.VERTICAL,
                    checkColor: Colors.purpleAccent,
                    activeColor: Colors.lightBlue,
                  ),
                ],
              ),
              Text("¿Cuando empezaron sus sintomas por primera vez?",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 10),
                child: TextField(
                  controller: _fechaController,
                  autofocus: false,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "¿Le han diagnosticado alguna de las siguientes enfermedades?",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  GroupedCheckbox(
                    wrapSpacing: 10.0,
                    wrapRunSpacing: 15.0,
                    wrapRunAlignment: WrapAlignment.center,
                    wrapVerticalDirection: VerticalDirection.down,
                    wrapAlignment: WrapAlignment.center,
                    itemList: allItemList1,
                    checkedItemList: checkedItemList1,
                    onChanged: (itemList1) {
                      setState(() {
                        selectedItemList1 = itemList1;
                        print('SELECTED ITEM LIST1 $itemList1');
                      });
                    },
                    orientation: CheckboxOrientation.VERTICAL,
                    checkColor: Colors.purpleAccent,
                    activeColor: Colors.lightBlue,
                  ),
                ],
              ),
              RaisedButton(
                  color: Colors.green[300],
                  child: Text("Guardar", style: TextStyle(fontSize: 20)),
                  onPressed: () async {
                    formu.preg8 = _SelectedDepartamentos.name;
                    formu.preg9 = _SelectedMunicipios.name;
                    formu.preg10 = preg10;
                    formu.preg11 = preg11;
                    formu.preg12 = selectedItemList;
                    formu.preg13 = _fechaController.text;
                    formu.preg14 = selectedItemList1;

                    var firebaseUser =
                        await FirebaseAuth.instance.currentUser();

                    Firestore.instance
                        .collection("users")
                        .document(firebaseUser.uid)
                        .updateData({
                      "usuarios": FieldValue.arrayUnion([
                        {
                          "creacion": DateFormat("dd-MM-yyyy hh:mm:ss")
                              .format(DateTime.now())
                              .toString(),
                          "nombre": formu.nombre,
                          "edad": formu.edad,
                          "genero": formu.genero,
                          "correo": formu.correo,
                          "estrato": formu.estrato,
                          "¿Ha viajado a algún DEPARTAMENTO de colombia en los últimos 14 días?":
                              formu.preg8,
                          "¿Ha viajado a algún MUNICIPIO de colombia en los últimos 14 días?":
                              formu.preg9,
                          "¿Ha viajado a otros paises en los últimos 14 días?":
                              formu.preg10,
                          "¿Ha tenido contacto con personas que hayan viajado a otros paises en los últimos 14 días?":
                              formu.preg11,
                          "Marque si ha presentado alguno de los sintomas que se detallan a continuación en los últimos 14 días":
                              formu.preg12,
                          "¿Cuando empezaron sus sintomas por primera vez?":
                              formu.preg13,
                          "¿Le han diagnosticado alguna de las siguientes enfermedades?":
                              formu.preg14
                        }
                      ]),
                    }).then((_) {
                      print("Success!");
                    });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserScreen()));
                  })
            ],
          ),
        ));
  }
}
