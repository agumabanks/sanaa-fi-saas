// To parse this JSON data, do
//
//     final loanStatisticsModal = loanStatisticsModalFromJson(jsonString);

import 'dart:convert';

LoanStatisticsModal loanStatisticsModalFromJson(String str) => LoanStatisticsModal.fromJson(json.decode(str));

String loanStatisticsModalToJson(LoanStatisticsModal data) => json.encode(data.toJson());

class LoanStatisticsModal {
    DateTime? date;
    int? loansDisbursed;
    int? numberOfLoansDisbursed;
    int? loansRepaid;
    int? numberOfLoansRepaid;
    int? overdueLoansAmount;
    int? numberOfOverdueLoans;

    LoanStatisticsModal({
        this.date,
        this.loansDisbursed,
        this.numberOfLoansDisbursed,
        this.loansRepaid,
        this.numberOfLoansRepaid,
        this.overdueLoansAmount,
        this.numberOfOverdueLoans,
    });

    factory LoanStatisticsModal.fromJson(Map<String, dynamic> json) => LoanStatisticsModal(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        loansDisbursed: json["loans_disbursed"],
        numberOfLoansDisbursed: json["number_of_loans_disbursed"],
        loansRepaid: json["loans_repaid"],
        numberOfLoansRepaid: json["number_of_loans_repaid"],
        overdueLoansAmount: json["overdue_loans_amount"],
        numberOfOverdueLoans: json["number_of_overdue_loans"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "loans_disbursed": loansDisbursed,
        "number_of_loans_disbursed": numberOfLoansDisbursed,
        "loans_repaid": loansRepaid,
        "number_of_loans_repaid": numberOfLoansRepaid,
        "overdue_loans_amount": overdueLoansAmount,
        "number_of_overdue_loans": numberOfOverdueLoans,
    };
}
