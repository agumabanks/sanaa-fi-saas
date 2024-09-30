// To parse this JSON data, do
//
//     final clientData = clientDataFromJson(jsonString);

import 'dart:convert';

ClientData clientDataFromJson(String str) => ClientData.fromJson(json.decode(str));

String clientDataToJson(ClientData data) => json.encode(data.toJson());

class ClientData {
    bool? success;
    Data? data;

    ClientData({
        this.success,
        this.data,
    });

    factory ClientData.fromJson(Map<String, dynamic> json) => ClientData(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    Client? client;
    Agent? agent;
    List<dynamic>? guarantors;
    List<LoanPaymentHistory>? loanPaymentHistory;
    List<ClientLoan>? clientLoans;

    Data({
        this.client,
        this.agent,
        this.guarantors,
        this.loanPaymentHistory,
        this.clientLoans,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
        guarantors: json["guarantors"] == null ? [] : List<dynamic>.from(json["guarantors"]!.map((x) => x)),
        loanPaymentHistory: json["loan_payment_history"] == null ? [] : List<LoanPaymentHistory>.from(json["loan_payment_history"]!.map((x) => LoanPaymentHistory.fromJson(x))),
        clientLoans: json["client_loans"] == null ? [] : List<ClientLoan>.from(json["client_loans"]!.map((x) => ClientLoan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "client": client?.toJson(),
        "agent": agent?.toJson(),
        "guarantors": guarantors == null ? [] : List<dynamic>.from(guarantors!.map((x) => x)),
        "loan_payment_history": loanPaymentHistory == null ? [] : List<dynamic>.from(loanPaymentHistory!.map((x) => x.toJson())),
        "client_loans": clientLoans == null ? [] : List<dynamic>.from(clientLoans!.map((x) => x.toJson())),
    };
}

class Agent {
    int? id;
    String? fName;
    String? lName;
    String? dialCountryCode;
    String? phone;
    dynamic email;
    String? image;
    int? type;
    dynamic role;
    int? isPhoneVerified;
    int? isEmailVerified;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? lastActiveAt;
    String? uniqueId;
    dynamic referralId;
    String? gender;
    String? occupation;
    int? twoFactor;
    String? fcmToken;
    int? isActive;
    dynamic identificationType;
    dynamic identificationNumber;
    String? identificationImage;
    int? isKycVerified;
    int? loginHitCount;
    int? isTempBlocked;
    dynamic tempBlockTime;
    dynamic deletedAt;
    String? imageFullpath;
    List<dynamic>? identificationImageFullpath;
    List<dynamic>? merchantIdentificationImageFullpath;

    Agent({
        this.id,
        this.fName,
        this.lName,
        this.dialCountryCode,
        this.phone,
        this.email,
        this.image,
        this.type,
        this.role,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.createdAt,
        this.updatedAt,
        this.lastActiveAt,
        this.uniqueId,
        this.referralId,
        this.gender,
        this.occupation,
        this.twoFactor,
        this.fcmToken,
        this.isActive,
        this.identificationType,
        this.identificationNumber,
        this.identificationImage,
        this.isKycVerified,
        this.loginHitCount,
        this.isTempBlocked,
        this.tempBlockTime,
        this.deletedAt,
        this.imageFullpath,
        this.identificationImageFullpath,
        this.merchantIdentificationImageFullpath,
    });

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        dialCountryCode: json["dial_country_code"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        type: json["type"],
        role: json["role"],
        isPhoneVerified: json["is_phone_verified"],
        isEmailVerified: json["is_email_verified"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        lastActiveAt: json["last_active_at"] == null ? null : DateTime.parse(json["last_active_at"]),
        uniqueId: json["unique_id"],
        referralId: json["referral_id"],
        gender: json["gender"],
        occupation: json["occupation"],
        twoFactor: json["two_factor"],
        fcmToken: json["fcm_token"],
        isActive: json["is_active"],
        identificationType: json["identification_type"],
        identificationNumber: json["identification_number"],
        identificationImage: json["identification_image"],
        isKycVerified: json["is_kyc_verified"],
        loginHitCount: json["login_hit_count"],
        isTempBlocked: json["is_temp_blocked"],
        tempBlockTime: json["temp_block_time"],
        deletedAt: json["deleted_at"],
        imageFullpath: json["image_fullpath"],
        identificationImageFullpath: json["identification_image_fullpath"] == null ? [] : List<dynamic>.from(json["identification_image_fullpath"]!.map((x) => x)),
        merchantIdentificationImageFullpath: json["merchant_identification_image_fullpath"] == null ? [] : List<dynamic>.from(json["merchant_identification_image_fullpath"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "dial_country_code": dialCountryCode,
        "phone": phone,
        "email": email,
        "image": image,
        "type": type,
        "role": role,
        "is_phone_verified": isPhoneVerified,
        "is_email_verified": isEmailVerified,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "last_active_at": lastActiveAt?.toIso8601String(),
        "unique_id": uniqueId,
        "referral_id": referralId,
        "gender": gender,
        "occupation": occupation,
        "two_factor": twoFactor,
        "fcm_token": fcmToken,
        "is_active": isActive,
        "identification_type": identificationType,
        "identification_number": identificationNumber,
        "identification_image": identificationImage,
        "is_kyc_verified": isKycVerified,
        "login_hit_count": loginHitCount,
        "is_temp_blocked": isTempBlocked,
        "temp_block_time": tempBlockTime,
        "deleted_at": deletedAt,
        "image_fullpath": imageFullpath,
        "identification_image_fullpath": identificationImageFullpath == null ? [] : List<dynamic>.from(identificationImageFullpath!.map((x) => x)),
        "merchant_identification_image_fullpath": merchantIdentificationImageFullpath == null ? [] : List<dynamic>.from(merchantIdentificationImageFullpath!.map((x) => x)),
    };
}

class Client {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? address;
    String? status;
    dynamic kycVerifiedAt;
    dynamic dob;
    dynamic business;
    dynamic nin;
    dynamic recommenders;
    String? creditBalance;
    String? savingsBalance;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? addedBy;
    dynamic clientPhoto;
    dynamic nextOfKin;
    dynamic nationalIdPhoto;

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
        status: json["status"],
        kycVerifiedAt: json["kyc_verified_at"],
        dob: json["dob"],
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
        "status": status,
        "kyc_verified_at": kycVerifiedAt,
        "dob": dob,
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

class ClientLoan {
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

    ClientLoan({
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

    factory ClientLoan.fromJson(Map<String, dynamic> json) => ClientLoan(
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

class LoanPaymentHistory {
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

    LoanPaymentHistory({
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

    factory LoanPaymentHistory.fromJson(Map<String, dynamic> json) => LoanPaymentHistory(
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
