import 'package:flutter/material.dart';
import 'package:mi_termometro/widgets/color_loader.dart';

class FailBT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.bluetooth_disabled,
                      size: 180.0,
                      color: Colors.blue[300],
                    ),
                    Icon(
                      Icons.location_off,
                      size: 180.0,
                      color: Colors.blue[300],
                    ),
                  ]),
              ColorLoader2(),
              Text(
                'Por favor encienda el bluetooth y su ubicación.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    .copyWith(color: Colors.black, fontSize: 22),
              ),
            ]),
      ),
    );
  }
}
