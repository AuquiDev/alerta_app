class Usermodels {
  int? id;
  String fullname;
  String dni;
  String address;
  String phone;
  String? password;

  Usermodels(
      {this.id,
      required this.fullname,
      required this.dni,
      required this.address,
      required this.phone,
      this.password});

  factory Usermodels.fromJson(Map<String, dynamic> json) => Usermodels(
        // id: json['id'] ?? 0,
        fullname: json["nombreCompleto"],
        dni: json["dni"],
        address: json["direccion"],
        phone: json["telefono"],
        // password: json["password"] ?? "",
      );
}
