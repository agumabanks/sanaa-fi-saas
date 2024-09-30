// To parse this JSON data, do
//
//     final allLoanPlans = allLoanPlansFromJson(jsonString);

import 'dart:convert';

AllLoanPlans allLoanPlansFromJson(String str) => AllLoanPlans.fromJson(json.decode(str));

String allLoanPlansToJson(AllLoanPlans data) => json.encode(data.toJson());

class AllLoanPlans {
    String? status;
    List<Datum>? data;

    AllLoanPlans({
        this.status,
        this.data,
    });

    factory AllLoanPlans.fromJson(Map<String, dynamic> json) => AllLoanPlans(
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
    String? planName;
    String? minAmount;
    String? maxAmount;
    String? installmentValue;
    int? installmentInterval;
    int? totalInstallments;
    String? instructions;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.planName,
        this.minAmount,
        this.maxAmount,
        this.installmentValue,
        this.installmentInterval,
        this.totalInstallments,
        this.instructions,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        planName: json["plan_name"],
        minAmount: json["min_amount"],
        maxAmount: json["max_amount"],
        installmentValue: json["installment_value"],
        installmentInterval: json["installment_interval"],
        totalInstallments: json["total_installments"],
        instructions: json["instructions"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plan_name": planName,
        "min_amount": minAmount,
        "max_amount": maxAmount,
        "installment_value": installmentValue,
        "installment_interval": installmentInterval,
        "total_installments": totalInstallments,
        "instructions": instructions,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
