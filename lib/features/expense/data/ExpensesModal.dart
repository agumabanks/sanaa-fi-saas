// To parse this JSON data, do
//
//     final expensesModal = expensesModalFromJson(jsonString);

import 'dart:convert';

ExpensesModal expensesModalFromJson(String str) => ExpensesModal.fromJson(json.decode(str));

String expensesModalToJson(ExpensesModal data) => json.encode(data.toJson());

class ExpensesModal {
    String? status;
    List<Datum>? data;

    ExpensesModal({
        this.status,
        this.data,
    });

    factory ExpensesModal.fromJson(Map<String, dynamic> json) => ExpensesModal(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? transactionId;
    String? description;
    String? amount;
    DateTime? time;
    String? category;
    String? paymentMethod;
    String? notes;
    int? addedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.transactionId,
        this.description,
        this.amount,
        this.time,
        this.category,
        this.paymentMethod,
        this.notes,
        this.addedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        transactionId: json["transaction_id"],
        description: json["description"],
        amount: json["amount"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        category: json["category"],
        paymentMethod: json["payment_method"],
        notes: json["notes"],
        addedBy: json["added_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "description": description,
        "amount": amount,
        "time": time?.toIso8601String(),
        "category": category,
        "payment_method": paymentMethod,
        "notes": notes,
        "added_by": addedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
