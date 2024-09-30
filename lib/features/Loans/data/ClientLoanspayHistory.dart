// To parse this JSON data, do
//
//     final clientLoanspayHistory = clientLoanspayHistoryFromJson(jsonString);

import 'dart:convert';

ClientLoanspayHistory clientLoanspayHistoryFromJson(String str) => ClientLoanspayHistory.fromJson(json.decode(str));

String clientLoanspayHistoryToJson(ClientLoanspayHistory data) => json.encode(data.toJson());

class ClientLoanspayHistory {
    String? responseCode;
    String? message;
    List<Content>? content;
    dynamic errors;

    ClientLoanspayHistory({
        this.responseCode,
        this.message,
        this.content,
        this.errors,
    });

    factory ClientLoanspayHistory.fromJson(Map<String, dynamic> json) => ClientLoanspayHistory(
        responseCode: json["response_code"],
        message: json["message"],
        content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
        errors: json["errors"],
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        "errors": errors,
    };
}

class Content {
    int? id;
    int? loanId;
    int? clientId;
    int? agentId;
    String? amount;
    int? isReversed;
    dynamic reversalReason;
    String? creditBalance;
    DateTime? paymentDate;
    dynamic note;
    DateTime? createdAt;
    DateTime? updatedAt;

    Content({
        this.id,
        this.loanId,
        this.clientId,
        this.agentId,
        this.amount,
        this.isReversed,
        this.reversalReason,
        this.creditBalance,
        this.paymentDate,
        this.note,
        this.createdAt,
        this.updatedAt,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        loanId: json["loan_id"],
        clientId: json["client_id"],
        agentId: json["agent_id"],
        amount: json["amount"],
        isReversed: json["is_reversed"],
        reversalReason: json["reversal_reason"],
        creditBalance: json["credit_balance"],
        paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
        note: json["note"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "loan_id": loanId,
        "client_id": clientId,
        "agent_id": agentId,
        "amount": amount,
        "is_reversed": isReversed,
        "reversal_reason": reversalReason,
        "credit_balance": creditBalance,
        "payment_date": "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
