class user_Register_Model {
  String? name;
  String? email;
  String? password;
  String? address;
  String? phone;
  String? gender;
  String? uid;
 

  user_Register_Model(
      {
        this.name, 
        this.email, 
        this.password,
        this.address,
        this.phone, 
        this.gender, 
        this.uid
      });

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "address": address,
      "phone": phone,
      "gender": gender,
      
      "uid": uid
    };
  }
}