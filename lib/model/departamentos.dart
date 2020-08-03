class Departamentos {
  int id;
  String name;

  Departamentos(this.id, this.name);

  static List<Departamentos> getDepartamentos() {
    return <Departamentos>[
      Departamentos(1, "Amazonas"),
      Departamentos(2, "Antioquia"),
      Departamentos(3, "Arauca"),
      Departamentos(
          4, "Archipiélago de San Andrés, Providencia y Santa Catalina"),
      Departamentos(5, "Atlántico"),
      Departamentos(6, "Bogotá D.C."),
      Departamentos(7, "Bolívar"),
      Departamentos(8, "Boyacá"),
      Departamentos(9, "Caldas"),
      Departamentos(10, "Caquetá"),
      Departamentos(11, "Casanare"),
      Departamentos(12, "Cauca"),
      Departamentos(13, "Cesar"),
      Departamentos(14, "Chocó"),
      Departamentos(15, "Córdoba"),
      Departamentos(16, "Cundinamarca"),
      Departamentos(17, "Guainía"),
      Departamentos(18, "Guaviare"),
      Departamentos(19, "Huila"),
      Departamentos(20, "La Guajira"),
      Departamentos(21, "Magdalena"),
      Departamentos(22, "Meta"),
      Departamentos(23, "Nariño"),
      Departamentos(24, "Norte de Santander"),
      Departamentos(25, "Putumayo"),
      Departamentos(26, "Quindío"),
      Departamentos(27, "Risaralda"),
      Departamentos(28, "Santander"),
      Departamentos(29, "Sucre"),
      Departamentos(30, "Tolima"),
      Departamentos(31, "Valle del Cauca"),
      Departamentos(32, "Vaupés"),
      Departamentos(33, "Vichada"),
      Departamentos(34, "Ninguno")
    ];
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
