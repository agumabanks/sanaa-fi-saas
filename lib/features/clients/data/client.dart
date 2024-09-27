// lib/models/all_clients.dart

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
    int? id;
    String? name;
    String? email;
    String? phone;
    String? nin;
    DateTime? createdAt;
    AddedBy? addedBy;

    Datum({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.nin,
        this.createdAt,
        this.addedBy,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        nin: json["nin"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        addedBy: addedByValues.map[json["added_by"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "nin": nin,
        "created_at": createdAt?.toIso8601String(),
        "added_by": addedByValues.reverse[addedBy],
    };
}

enum AddedBy {
    AMBASIZE_DANIEL,
    GG_GG,
    KAHAMA_DAN
}

final addedByValues = EnumValues({
    "AMBASIZE DANIEL": AddedBy.AMBASIZE_DANIEL,
    "Gg Gg": AddedBy.GG_GG,
    "Kahama DAN": AddedBy.KAHAMA_DAN
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
