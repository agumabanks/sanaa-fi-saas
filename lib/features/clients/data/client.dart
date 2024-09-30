
import 'dart:convert';

AllClients allClientsFromJson(String str) => AllClients.fromJson(json.decode(str));

String allClientsToJson(AllClients data) => json.encode(data.toJson());

class AllClients {
    bool? success;
    List<Datum>? data;
    Pagination? pagination;

    AllClients({
        this.success,
        this.data,
        this.pagination,
    });

    factory AllClients.fromJson(Map<String, dynamic> json) => AllClients(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class Datum {
    Client? client;
    String? addedByName;

    Datum({
        this.client,
        this.addedByName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        addedByName: json["added_by_name"] ?? 'N/A', // Fallback to 'N/A' if null
    );

    Map<String, dynamic> toJson() => {
        "client": client?.toJson(),
        "added_by_name": addedByName,
    };
}

class Client {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? address;
    Status? status;
    DateTime? kycVerifiedAt;
    DateTime? dob;
    String? business;
    String? nin;
    dynamic recommenders;
    String? creditBalance;
    String? savingsBalance;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? addedBy;
    String? clientPhoto;
    String? nextOfKin;
    String? nationalIdPhoto;

    Client({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.status,
        this.kycVerifiedAt,
        this.dob,
        this.business,
        this.nin,
        this.recommenders,
        this.creditBalance,
        this.savingsBalance,
        this.createdAt,
        this.updatedAt,
        this.addedBy,
        this.clientPhoto,
        this.nextOfKin,
        this.nationalIdPhoto,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        status: json["status"] != null ? statusValues.map[json["status"].toLowerCase()] : null,
        kycVerifiedAt: json["kyc_verified_at"] == null ? null : DateTime.parse(json["kyc_verified_at"]),
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        business: json["business"],
        nin: json["nin"],
        recommenders: json["recommenders"],
        creditBalance: json["credit_balance"],
        savingsBalance: json["savings_balance"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        addedBy: json["added_by"],
        clientPhoto: json["client_photo"],
        nextOfKin: json["next_of_kin"],
        nationalIdPhoto: json["national_id_photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "status": statusValues.reverse[status],
        "kyc_verified_at": kycVerifiedAt?.toIso8601String(),
        "dob": dob?.toIso8601String(),
        "business": business,
        "nin": nin,
        "recommenders": recommenders,
        "credit_balance": creditBalance,
        "savings_balance": savingsBalance,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "added_by": addedBy,
        "client_photo": clientPhoto,
        "next_of_kin": nextOfKin,
        "national_id_photo": nationalIdPhoto,
    };
}

enum Status {
    ACTIVE,
    DFGDFG,
    STATUS_ACTIVE
}

final statusValues = EnumValues({
    "active": Status.ACTIVE,
    "dfgdfg": Status.DFGDFG,
    "active": Status.STATUS_ACTIVE
});

class Pagination {
    int? total;
    int? count;
    int? perPage;
    int? currentPage;
    int? totalPages;

    Pagination({
        this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}






// // lib/models/all_clients.dart

// import 'dart:convert';

// AllClients allClientsFromJson(String str) => AllClients.fromJson(json.decode(str));

// String allClientsToJson(AllClients data) => json.encode(data.toJson());

// class AllClients {
//     bool? success;
//     List<Datum>? data;
//     Pagination? pagination;

//     AllClients({
//         this.success,
//         this.data,
//         this.pagination,
//     });

//     factory AllClients.fromJson(Map<String, dynamic> json) => AllClients(
//         success: json["success"],
//         data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//         pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "pagination": pagination?.toJson(),
//     };
// }

// class Datum {
//     int? id;
//     String? name;
//     String? email;
//     String? phone;
//     String? nin;
//     DateTime? createdAt;
//     AddedBy? addedBy;

//     Datum({
//         this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.nin,
//         this.createdAt,
//         this.addedBy,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         nin: json["nin"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         addedBy: addedByValues.map.containsKey(json["added_by"]) ? addedByValues.map[json["added_by"]] : null,

//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "nin": nin,
//         "created_at": createdAt?.toIso8601String(),
//         "added_by": addedByValues.reverse[addedBy],
//     };
// }

// enum AddedBy {
//     AMBASIZE_DANIEL,
//     GG_GG,
//     KAHAMA_DAN
// }

// final addedByValues = EnumValues({
//     "AMBASIZE DANIEL": AddedBy.AMBASIZE_DANIEL,
//     "Gg Gg": AddedBy.GG_GG,
//     "Kahama DAN": AddedBy.KAHAMA_DAN
// });

// class Pagination {
//     int? total;
//     int? count;
//     int? perPage;
//     int? currentPage;
//     int? totalPages;

//     Pagination({
//         this.total,
//         this.count,
//         this.perPage,
//         this.currentPage,
//         this.totalPages,
//     });

//     factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         count: json["count"],
//         perPage: json["per_page"],
//         currentPage: json["current_page"],
//         totalPages: json["total_pages"],
//     );

//     Map<String, dynamic> toJson() => {
//         "total": total,
//         "count": count,
//         "per_page": perPage,
//         "current_page": currentPage,
//         "total_pages": totalPages,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//             reverseMap = map.map((k, v) => MapEntry(v, k));
//             return reverseMap;
//     }
// }
