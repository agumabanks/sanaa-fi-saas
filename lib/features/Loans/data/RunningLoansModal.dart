// To parse this JSON data, do
//
//     final RunningLoansModal = RunningLoansModalFromJson(jsonString);

import 'dart:convert';

RunningLoansModal RunningLoansModalFromJson(String str) => RunningLoansModal.fromJson(json.decode(str));

String RunningLoansModalToJson(RunningLoansModal data) => json.encode(data.toJson());

class RunningLoansModal {
    String? status;
    String? pageTitle;
    String? emptyMessage;
    List<RunningLoansModalDatum>? data;
    Pagination? pagination;

    RunningLoansModal({
        this.status,
        this.pageTitle,
        this.emptyMessage,
        this.data,
        this.pagination,
    });

    factory RunningLoansModal.fromJson(Map<String, dynamic> json) => RunningLoansModal(
        status: json["status"],
        pageTitle: json["page_title"],
        emptyMessage: json["empty_message"],
        data: json["data"] == null ? [] : List<RunningLoansModalDatum>.from(json["data"]!.map((x) => RunningLoansModalDatum.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "page_title": pageTitle,
        "empty_message": emptyMessage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class RunningLoansModalDatum {
    int? id;
    String? trx;
    String? amount;
    int? status;
    Ent? agent;
    Ent? client;
    DateTime? createdAt;
    DateTime? updatedAt;

    RunningLoansModalDatum({
        this.id,
        this.trx,
        this.amount,
        this.status,
        this.agent,
        this.client,
        this.createdAt,
        this.updatedAt,
    });

    factory RunningLoansModalDatum.fromJson(Map<String, dynamic> json) => RunningLoansModalDatum(
        id: json["id"],
        trx: json["trx"],
        amount: json["amount"],
        status: json["status"],
        agent: json["agent"] == null ? null : Ent.fromJson(json["agent"]),
        client: json["client"] == null ? null : Ent.fromJson(json["client"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "trx": trx,
        "amount": amount,
        "status": status,
        "agent": agent?.toJson(),
        "client": client?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Ent {
    int? id;
    String? name;
    String? phone;

    Ent({
        this.id,
        this.name,
        this.phone,
    });

    factory Ent.fromJson(Map<String, dynamic> json) => Ent(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
    };
}

class Pagination {
    int? currentPage;
    int? total;
    int? perPage;
    int? lastPage;

    Pagination({
        this.currentPage,
        this.total,
        this.perPage,
        this.lastPage,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        total: json["total"],
        perPage: json["per_page"],
        lastPage: json["last_page"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total": total,
        "per_page": perPage,
        "last_page": lastPage,
    };
}
