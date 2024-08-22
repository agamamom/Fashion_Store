class VendorUserModel {
  VendorUserModel(
      {required this.approved,
      required this.bussinessName,
      required this.cityValue,
      required this.vendorId,
      required this.countryValue,
      required this.email,
      required this.phoneNumber,
      required this.stateValue,
      required this.storeImage,
      required this.taxNumber,
      required this.taxRegistered});

  final bool approved;
  final String bussinessName;
  final String cityValue;
  final String countryValue;
  final String email;
  final String vendorId;
  final String phoneNumber;
  final String stateValue;
  final String storeImage;
  final String taxNumber;
  final String taxRegistered;

  VendorUserModel.fromJson(Map<String, dynamic> json)
      : this(
          approved: json['approved']! as bool,
          bussinessName: json['bussinessName']! as String,
          vendorId: json['vendorId']! as String,
          cityValue: json['cityValue']! as String,
          countryValue: json['countryValue']! as String,
          email: json['email']! as String,
          phoneNumber: json['phoneNumber']! as String,
          stateValue: json['stateValue']! as String,
          storeImage: json['storeImage']! as String,
          taxNumber: json['taxNumber']! as String,
          taxRegistered: json['taxRegistered']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'bussinessName': bussinessName,
      'vendorId': vendorId,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'email': email,
      'phoneNumber': phoneNumber,
      'stateValue': stateValue,
      'storeImage': storeImage,
      'taxNumber': taxNumber,
      'taxRegistered': taxRegistered
    };
  }
}
