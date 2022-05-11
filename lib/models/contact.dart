class Contact {
  String username;
  String phone;
  String email;
  String country;
  String city;

  Contact(this.username, this.phone, this.email, this.country, this.city);

  Contact.fromMap(Map<String, dynamic> data)
      : username = data['username'],
        phone = data['phone'],
        email = data['email'],
        country = data['country'],
        city = data['city'];

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'phone': phone,
      'email': email,
      'country': country,
      'city': city,
    };
  }

  Contact.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        phone = json['phone'],
        email = json['email'],
        country = json['country'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'phone': phone,
        'email': email,
        'country': country,
        'city': city,
      };
}
