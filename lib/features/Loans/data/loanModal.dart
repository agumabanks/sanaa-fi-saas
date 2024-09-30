// To parse this JSON data, do
//
//     final allLoans = allLoansFromJson(jsonString);

import 'dart:convert';

AllLoans allLoansFromJson(String str) => AllLoans.fromJson(json.decode(str));

String allLoansToJson(AllLoans data) => json.encode(data.toJson());

class AllLoans {
    String? status;
    String? pageTitle;
    String? emptyMessage;
    Data? data;

    AllLoans({
        this.status,
        this.pageTitle,
        this.emptyMessage,
        this.data,
    });

    factory AllLoans.fromJson(Map<String, dynamic> json) => AllLoans(
        status: json["status"],
        pageTitle: json["page_title"],
        emptyMessage: json["empty_message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "page_title": pageTitle,
        "empty_message": emptyMessage,
        "data": data?.toJson(),
    };
}

class Data {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int? id;
    int? userId;
    int? clientId;
    int? planId;
    String? trx;
    String? amount;
    DateTime? dueDate;
    DateTime? disbursedAt;
    String? perInstallment;
    int? installmentInterval;
    int? totalInstallment;
    int? givenInstallment;
    String? paidAmount;
    String? finalAmount;
    String? processingFee;
    dynamic userDetails;
    dynamic adminFeedback;
    int? status;
    DateTime? nextInstallmentDate;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.userId,
        this.clientId,
        this.planId,
        this.trx,
        this.amount,
        this.dueDate,
        this.disbursedAt,
        this.perInstallment,
        this.installmentInterval,
        this.totalInstallment,
        this.givenInstallment,
        this.paidAmount,
        this.finalAmount,
        this.processingFee,
        this.userDetails,
        this.adminFeedback,
        this.status,
        this.nextInstallmentDate,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        clientId: json["client_id"],
        planId: json["plan_id"],
        trx: json["trx"],
        amount: json["amount"],
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        disbursedAt: json["disbursed_at"] == null ? null : DateTime.parse(json["disbursed_at"]),
        perInstallment: json["per_installment"],
        installmentInterval: json["installment_interval"],
        totalInstallment: json["total_installment"],
        givenInstallment: json["given_installment"],
        paidAmount: json["paid_amount"],
        finalAmount: json["final_amount"],
        processingFee: json["processing_fee"],
        userDetails: json["user_details"],
        adminFeedback: json["admin_feedback"],
        status: json["status"],
        nextInstallmentDate: json["next_installment_date"] == null ? null : DateTime.parse(json["next_installment_date"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "client_id": clientId,
        "plan_id": planId,
        "trx": trx,
        "amount": amount,
        "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "disbursed_at": "${disbursedAt!.year.toString().padLeft(4, '0')}-${disbursedAt!.month.toString().padLeft(2, '0')}-${disbursedAt!.day.toString().padLeft(2, '0')}",
        "per_installment": perInstallment,
        "installment_interval": installmentInterval,
        "total_installment": totalInstallment,
        "given_installment": givenInstallment,
        "paid_amount": paidAmount,
        "final_amount": finalAmount,
        "processing_fee": processingFee,
        "user_details": userDetails,
        "admin_feedback": adminFeedback,
        "status": status,
        "next_installment_date": nextInstallmentDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
