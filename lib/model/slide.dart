import 'package:flutter/material.dart';

class Slide {
  final String imageURL;
  final String title;
  final String description;

  Slide({
    @required this.imageURL,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
      imageURL: 'assets/images/persona.jpg',
      title: 'Iniciar sesión',
      description:
          'Si es su primera vez usando Mi termómetro, debe registrarse con un correo y contraseña , si ya tiene una cuenta, puede ingresar normalmente.'),
  Slide(
      imageURL: 'assets/images/image2.jpg',
      title: 'Conecta tu termómetro',
      description:
          'Para emparejar el dispositivo debe activar su Bluetooth y ubicación. Luego, seleccione el dispositivo llamado "Mi_termometro".'),
  Slide(
      imageURL: 'assets/images/image3.jpg',
      title: 'Iniciar Medición',
      description:
          'Ubique el termómetro a una distancia máx. 5 cm del oido interno, durante 2 seg. La medición se guardará en la sección de resultados.'),
  Slide(
      imageURL: 'assets/images/image4.jpg',
      title: 'Duración de medida',
      description:
          'Aparecerá un cronómetro, que le indicará el tiempo que lleva midiendo.\n\n'),
  Slide(
      imageURL: 'assets/images/image5.jpg',
      title: 'Resultados',
      description:
          'En una gráfica podrá ver sus temperaturas medidas con su respectiva fecha y hora. Siempre podrá reintentar la medición.\n'),
];
