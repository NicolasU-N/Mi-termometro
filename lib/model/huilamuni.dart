class Municipios {
  int id;
  String name;

  Municipios(this.id, this.name);

  static List<Municipios> getMunicipios() {
    return <Municipios>[
      Municipios(1, "Acevedo"),
      Municipios(2, "Agrado"),
      Municipios(3, "Aipe"),
      Municipios(4, "Algeciras"),
      Municipios(5, "Altamira"),
      Municipios(6, "Baraya"),
      Municipios(7, "Campoalegre"),
      Municipios(8, "Colombia"),
      Municipios(9, "El Pital"),
      Municipios(10, "Elías"),
      Municipios(11, "Garzón"),
      Municipios(12, "Gigante"),
      Municipios(13, "Guadalupe"),
      Municipios(14, "Hobo"),
      Municipios(15, "Íquira"),
      Municipios(16, "Isnos"),
      Municipios(17, "La Argentina"),
      Municipios(18, "La Plata"),
      Municipios(19, "Nátaga"),
      Municipios(20, "Neiva"),
      Municipios(21, "Oporapa"),
      Municipios(22, "Paicol"),
      Municipios(23, "Palermo"),
      Municipios(24, "Palestina"),
      Municipios(25, "Pitalito"),
      Municipios(26, "Rivera"),
      Municipios(27, "Saladoblanco"),
      Municipios(28, "San Agustín"),
      Municipios(29, "Santa María"),
      Municipios(30, "Suaza"),
      Municipios(31, "Tarqui"),
      Municipios(32, "Tello"),
      Municipios(33, "Teruel"),
      Municipios(34, "Tesalia"),
      Municipios(35, "Timaná"),
      Municipios(36, "Villavieja"),
      Municipios(37, "Yaguará"),
      Municipios(38, "Ninguno")
    ];
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
