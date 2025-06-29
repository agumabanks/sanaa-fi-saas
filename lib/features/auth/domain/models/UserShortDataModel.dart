class UserShortDataModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? countryCode;
  String? image;
  String? type;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  UserShortDataModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.countryCode,
    this.image,
    this.type,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  UserShortDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    countryCode = json['country_code'] ?? json['countryCode'] ?? json['dial_country_code'];
    image = json['image'];
    type = json['type'];
    isActive = json['is_active'] ?? json['isActive'];
    createdAt = json['created_at'] ?? json['createdAt'];
    updatedAt = json['updated_at'] ?? json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['image'] = image;
    data['type'] = type;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // Helper methods
  String get fullName => name ?? '';
  
  String get displayPhone {
    if (phone != null && countryCode != null) {
      return '$countryCode$phone';
    }
    return phone ?? '';
  }

  bool get hasImage => image != null && image!.isNotEmpty;

  bool get isValidUser {
    return id != null && 
           name != null && 
           phone != null && 
           name!.isNotEmpty && 
           phone!.isNotEmpty;
  }

  @override
  String toString() {
    return 'UserShortDataModel{id: $id, name: $name, phone: $phone, email: $email, countryCode: $countryCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserShortDataModel &&
        other.id == id &&
        other.phone == phone &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^ phone.hashCode ^ countryCode.hashCode;
  }

  // Copy with method for updating specific fields
  UserShortDataModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? countryCode,
    String? image,
    String? type,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserShortDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      image: image ?? this.image,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Create from minimal data (useful for registration flow)
  factory UserShortDataModel.minimal({
    required String name,
    required String phone,
    required String countryCode,
    String? email,
  }) {
    return UserShortDataModel(
      name: name,
      phone: phone,
      countryCode: countryCode,
      email: email,
      isActive: true,
    );
  }

  // Create empty instance
  factory UserShortDataModel.empty() {
    return UserShortDataModel();
  }
}