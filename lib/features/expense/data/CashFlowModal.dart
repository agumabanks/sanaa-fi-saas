// cash_flow_modal.dart

import 'dart:convert';

CashFlowModal cashFlowModalFromJson(String str) => CashFlowModal.fromJson(json.decode(str));

String cashFlowModalToJson(CashFlowModal data) => json.encode(data.toJson());

class CashFlowModal {
  String? status;
  List<CashFlowDatum>? data;

  CashFlowModal({
    this.status,
    this.data,
  });

  factory CashFlowModal.fromJson(Map<String, dynamic> json) => CashFlowModal(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<CashFlowDatum>.from(json["data"]!.map((x) => CashFlowDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CashFlowDatum {
  int? id;
  String? balanceBf;
  String? capitalAdded;
  String? cashBanked;
  DateTime? createdAt;
  DateTime? updatedAt;

  CashFlowDatum({
    this.id,
    this.balanceBf,
    this.capitalAdded,
    this.cashBanked,
    this.createdAt,
    this.updatedAt,
  });

  factory CashFlowDatum.fromJson(Map<String, dynamic> json) => CashFlowDatum(
        id: json["id"],
        balanceBf: json["balance_bf"],
        capitalAdded: json["capital_added"],
        cashBanked: json["cash_banked"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance_bf": balanceBf,
        "capital_added": capitalAdded,
        "cash_banked": cashBanked,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
