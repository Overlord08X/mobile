class AdressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  AdressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory AdressModel.fronJson(Map<String, dynamic> json) {
    return AdressModel(
      street: json['street'] ?? '',
      suite: json['suite'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'street': street, 'suite': suite, 'city': city, 'zipcode': zipcode};
  }
}

class DosenModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final AdressModel address;

  DosenModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      address: AdressModel.fronJson(json['address'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': address.toJson(),
    };
  }
}