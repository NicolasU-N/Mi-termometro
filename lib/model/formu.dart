class Formu {
  String nombre;
  String correo;
  String genero;
  String edad;
  String estrato;
  String preg8;
  String preg9;
  String preg10;
  String preg11;
  List<String> preg12;
  String preg13;
  List<String> preg14;

  Formu(this.nombre, this.correo, this.genero, this.edad, this.estrato,
      this.preg8, this.preg9, this.preg10, this.preg11, this.preg12);

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'correo': correo,
        'genero': genero,
        'edad': edad,
        'estrato': estrato,
        'preg8': preg8,
        'preg9': preg9,
        'preg10': preg10,
        'preg11': preg11,
        'preg12': preg12,
        'preg13': preg13,
        'preg14': preg14,
      };
}
