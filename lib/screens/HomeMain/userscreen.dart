import 'dart:async';
import 'dart:convert' show utf8;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mi_termometro/screens/HomeMain/main_drawer.dart';

import 'package:flutter_blue/flutter_blue.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> with WidgetsBindingObserver {
  final firestoreInstance = Firestore.instance;

  final SERVICE_UUID =
      "d39d2f80-94b3-11ea-bb37-0242ac130002"; // UART service UUID
  final CHARACTERISTIC_UUID = "d39d31e2-94b3-11ea-bb37-0242ac130002";
  final TARGET_DEVICE_NAME = "Mi termometro";

  String _tempAmb = "?";
  String _tempCor = "?";
  bool isReady = false;

  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription<ScanResult> scanSubScription;

  BluetoothDevice targetDevice;
  BluetoothCharacteristic targetCharacteristic;

  String connectionText = "";
  Stream<List<int>> stream;
  double _tempAmbl = 0;
  double _tempCorl = 0;

  bool estado = false;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  startScan() {
    setState(() {
      connectionText = "Start Scanning";
    });

    scanSubScription = flutterBlue.scan().listen((scanResult) {
      if (scanResult.device.name == TARGET_DEVICE_NAME) {
        print('DEVICE found');
        stopScan();
        setState(() {
          connectionText = "Found Target Device";
        });

        targetDevice = scanResult.device;
        connectToDevice();
      }
    }, onError: (e) => stopScan(), onDone: () => stopScan());
  }

  stopScan() {
    flutterBlue.stopScan();
    isReady = false;
    scanSubScription?.cancel();
    scanSubScription = null;
  }

  connectToDevice() async {
    if (targetDevice == null) return;

    setState(() {
      connectionText = "Device Connecting";
    });

    await targetDevice.connect();
    print('DEVICE CONNECTED');
    setState(() {
      connectionText = "Device Connected";
    });

    discoverServices();
  }

  disconnectFromDevice() {
    if (targetDevice == null) return;

    targetDevice.disconnect();

    setState(() {
      connectionText = "Device Disconnected";
    });
  }

  discoverServices() async {
    if (targetDevice == null) return;

    List<BluetoothService> services = await targetDevice.discoverServices();
    services.forEach((service) {
      // do something with service
      if (service.uuid.toString() == SERVICE_UUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;

            setState(() {
              isReady = true;
            });
          }
        });
      }
    });
  }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: MainDrawer(),
        body: Container(
            child: isReady == false
                ? Center(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.bluetooth_disabled,
                          size: 200.0,
                          color: Colors.blue[300],
                        ),
                        Icon(
                          Icons.location_off,
                          size: 200.0,
                          color: Colors.blue[300],
                        ),
                        Text(
                          'Por favor encienda el adaptador bluetooth y su ubicación. Apague y vuelva a encender el termómetro',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .subhead
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: StreamBuilder<List<int>>(
                      stream: stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<int>> snapshot) {
                        if (snapshot.hasError)
                          return Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.bluetooth_disabled,
                                  size: 200.0,
                                  color: Colors.blue[300],
                                ),
                                Icon(
                                  Icons.location_off,
                                  size: 200.0,
                                  color: Colors.blue[300],
                                ),
                                Text(
                                  'Por favor encienda el adaptador bluetooth y su ubicación. Apague y vuelva a encender el termómetro',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subhead
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          );

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          //traceDust.add(double.tryParse(currentValue) ?? "");

                          var cutrrent_value = _dataParser(snapshot.data);

                          if (estado) {
                            _tempAmbl =
                                double.parse(cutrrent_value.split(",")[0]);
                            _tempCorl =
                                double.parse(cutrrent_value.split(",")[1]);

                            if (_tempCorl >= 36 && _tempCorl <= 37.5) {
                              //print("ALERTA! Presencia de fiebre");
                            }

                            if (_tempCorl > 37.5 && _tempCorl <= 39) {
                              // print("ALERTA! Presencia de fFEBRICULA");
                            }
                          }

                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      MaterialButton(
                                          splashColor:
                                              Theme.of(context).primaryColor,
                                          minWidth: 200,
                                          height: 50,
                                          color: Colors.green,
                                          child: Text("Iniciar Medición ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          onPressed: () {
                                            estado = true;
                                          }),
                                      Text("\n"),
                                      Text(
                                          "TEMPERATURA AMBIENTE  ${_tempAmbl} °C",
                                          style: TextStyle(fontSize: 20)),
                                      Text(
                                          "TEMPERATURA CORPORAL   ${_tempCorl} °C",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Text("\n"),
                                      MaterialButton(
                                        minWidth: 200,
                                        height: 50,
                                        color: Colors.red[400],
                                        child: Text("Detener Medición ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                        onPressed: () async {
                                          estado = false;
                                          /*
                                          var firebaseUser = await FirebaseAuth
                                              .instance
                                              .currentUser();

                                          firestoreInstance
                                              .collection("users")
                                              .document(firebaseUser.uid)
                                              .updateData({
                                            "age": 60,
                                            "familyName": "Haddad",
                                            "address.street": "street 50",
                                            "address.country": "USA"
                                          }).then((_) {
                                            print("Success!");
                                          }); */
                                        },
                                      ),
                                    ]),
                              ),
                            ],
                          ));
                        } else {
                          //IMPORTANTE
                          return Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.bluetooth_disabled,
                                  size: 200.0,
                                  color: Colors.blue[300],
                                ),
                                Icon(
                                  Icons.location_off,
                                  size: 200.0,
                                  color: Colors.blue[300],
                                ),
                                Text(
                                  'Por favor encienda el adaptador bluetooth y su ubicación. Apague y vuelva a encender el termómetro',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subhead
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  )),
      ),
    );
  }
}
