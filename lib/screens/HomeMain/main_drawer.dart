import 'package:flutter/material.dart';
import 'package:mi_termometro/screens/getting_started_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mi_termometro/main.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainDrawer();
}

class _MainDrawer extends State<MainDrawer> with WidgetsBindingObserver {
  Map<String, dynamic> _useData = Map<String, dynamic>();
  bool _fetchingData = true;

  Future<void> _getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _useData['name'] = prefs.get('name');
        _useData['gender'] = prefs.get('gender');
        _useData['intro'] = prefs.get('intro');
        _useData['email'] = prefs.get('email');
        _useData['birth_year'] = prefs.get('birth_year');
        _useData['birth_month'] = prefs.get('birth_month');
        _useData['birth_day'] = prefs.get('birth_day');
        //_useData['image0'] = prefs.get('image0');
        //_useData['image1'] = prefs.get('image1');
        //_useData['image2'] = prefs.get('image2');
        //_useData['image3'] = prefs.get('image3');
        _useData['age'] = calculateAge(prefs.get('birth_year'),
            prefs.get('birth_month'), prefs.get('birth_day'));
        _fetchingData = false;
      });
    } catch (e) {}
  }

  calculateAge(int year, int month, int day) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - year;
    int month1 = currentDate.month;
    int month2 = month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  void _delete() async {
    // Cerrar sesion
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _fetchingData
        ? CircularProgressIndicator()
        : Drawer(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.account_circle,
                              size: 100,
                            ),
                          ),
                          Text(
                            _useData['name'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _useData['email'],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Edad: " + _useData['age'].toString() + " Años",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text(
                    "Manual",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GettingStartedScreen()), //UserScreen()
                    );
                  }, // REDIRECCIONAR A MANUAL
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    "Cerrar Sesión",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    _delete();
                  }, // REDIRECCIONAR A MANUAL
                ),
              ],
            ),
          );
  }
}
