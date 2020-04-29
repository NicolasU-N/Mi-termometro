import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(
    this.emailTextController,
    this.passwordTextController,
    this.nameTextController,
    this.cedulaController,
    this.parentAction,
    this.isWithSNS,
  );

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController nameTextController;
  final TextEditingController cedulaController;

  final ValueChanged<List<dynamic>> parentAction;

  bool isWithSNS = false;

  @override
  State<StatefulWidget> createState() => _SignUpForm();
}

enum GenderEnum { man, woman }

class _SignUpForm extends State<SignUpForm>
    with AutomaticKeepAliveClientMixin<SignUpForm> {
  // init data
  GenderEnum _userGender = GenderEnum.man;
  String _selectDateString = 'Seleccione su fecha de nacimiento';
  bool _agreedToTerm = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 22, DateTime.now().month),
        firstDate: DateTime(
            DateTime.now().year - 60, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month,
            DateTime.now().day));
    if (picked != null && picked != DateTime.now())
      setState(() {
        _selectDateString = "${picked.toLocal()}".split(' ')[0];
        _passDataToParent('birth_year', picked.year);
        _passDataToParent('birth_month', picked.month);
        _passDataToParent('birth_day', picked.day);
      });

    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _setAgreedToTerm(bool newValue) {
    _passDataToParent('term', newValue);
    setState(() {
      _agreedToTerm = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(14.0, 10, 14.0, 10),
      padding: const EdgeInsets.fromLTRB(14.0, 10, 14.0, 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 360,
            child: TextFormField(
              enabled: !widget.isWithSNS,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.mail,
                    color: !widget.isWithSNS ? Colors.grey : Colors.grey[300],
                  ),
                  labelText: 'Correo',
                  hintText: 'Escriba su correo'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'El correo es necesario';
                } else {
                  return null;
                }
              },
              style: TextStyle(
                  color: !widget.isWithSNS ? Colors.black : Colors.grey[400]),
              controller: widget.emailTextController,
            ),
          ),
          Divider(),
          SizedBox(
            width: 360,
            child: TextFormField(
              enabled: !widget.isWithSNS,
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.lock,
                    color: !widget.isWithSNS ? Colors.grey : Colors.grey[300],
                  ),
                  labelText: !widget.isWithSNS
                      ? 'Contraseña'
                      : 'No necesita contraseña',
                  hintText: 'Escriba su contraseña'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'La contraseña es necesaria';
                } else {
                  return null;
                }
              },
              style: TextStyle(
                  color: !widget.isWithSNS ? Colors.black : Colors.grey[300]),
              controller: widget.passwordTextController,
            ),
          ),
          Divider(),
          SizedBox(
            width: 360,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.account_circle),
                  labelText: 'Nombre',
                  hintText: 'Escriba su nombre'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Su nombre es necesario';
                } else {
                  return null;
                }
              },
              controller: widget.nameTextController,
            ),
          ),
          SizedBox(
            width: 360,
            child: TextFormField(
              keyboardType: TextInputType.number, // Solo ingresar números
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.credit_card),
                  labelText: 'Cédula',
                  hintText: 'Escriba el número de su cédula'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'El número de su cédula es requerida';
                } else {
                  return null;
                }
              },
              controller: widget.cedulaController,
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Icon(
                Icons.wc,
                color: Colors.grey,
              ),
              Radio(
                value: GenderEnum.man,
                groupValue: _userGender,
                onChanged: (GenderEnum value) {
                  setState(() {
                    _passDataToParent('gender', 'Hombre');
                    _userGender = value;
                  });
                },
              ),
              new GestureDetector(
                onTap: () {
                  setState(() {
                    _passDataToParent('gender', 'Hombre');
                    _userGender = GenderEnum.man;
                  });
                },
                child: Text('Hombre'),
              ),
              SizedBox(
                width: 20,
              ),
              Radio(
                value: GenderEnum.woman,
                groupValue: _userGender,
                onChanged: (GenderEnum value) {
                  setState(() {
                    _passDataToParent('gender', 'Mujer');
                    _userGender = value;
                  });
                },
              ),
              new GestureDetector(
                onTap: () {
                  setState(() {
                    _passDataToParent('gender', 'Mujer');
                    _userGender = GenderEnum.woman;
                  });
                },
                child: Text('Mujer'),
              ),
            ],
          ),
          Divider(),
          SizedBox(
            width: 360,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.cake,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Container(
                    width: 260,
                    child: RaisedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(_selectDateString),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: _agreedToTerm,
                    onChanged: _setAgreedToTerm,
                  ),
                  GestureDetector(
                    onTap: () {
                      _agreedToTerm = !_agreedToTerm;
                      _setAgreedToTerm(_agreedToTerm);
                    },
                    child: Text('Aceptar '),
                  ),
                  GestureDetector(
                    onTap: () => _showTermPolicy(),
                    child: const Text(
                      'Términos de servicios',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTermPolicy() {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text("SignInExample's Terms of Services, Privacy Policy"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
            height: 360,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Terms of Services, Privacy Policy' * 100),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            )
          ],
        ));
  }

  void _passDataToParent(String key, dynamic value) {
    List<dynamic> addData = List<dynamic>();
    addData.add(key);
    addData.add(value);
    widget.parentAction(addData);
  }

  @override
  bool get wantKeepAlive => true;
}
