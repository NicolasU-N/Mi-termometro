class Genero {
  int id;
  String name;

  Genero(this.id, this.name);

  static List<Genero> getGenero() {
    return <Genero>[
      Genero(1, "Femenino"),
      Genero(2, "Masculino"),
      Genero(3, "Prefiero no decir")
    ];
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
