import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';

import 'package:mi_termometro/screens/HomeMain/main_drawer.dart';

import 'package:flutter_blue/flutter_blue.dart';

class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> with WidgetsBindingObserver {
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
  List<double> _tempAmbl = List();
  List<double> _tempCorl = List();

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
                          var currentValue = _dataParser(snapshot.data);
                          print(currentValue);
                          //traceDust.add(double.tryParse(currentValue) ?? "");

                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Current value from Sensor',
                                          style: TextStyle(fontSize: 14)),
                                      Text(
                                          '\nTEMPERATURA AMBIENTE   || TEMPERATURA CORPORAL',
                                          style: TextStyle(fontSize: 30)),
                                      Text('${currentValue} °',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24))
                                    ]),
                              ),
                            ],
                          ));
                        } else {
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
