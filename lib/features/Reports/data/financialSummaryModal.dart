// To parse this JSON data, do
//
//     final financialSummaryModal = financialSummaryModalFromJson(jsonString);

import 'dart:convert';

FinancialSummaryModal financialSummaryModalFromJson(String str) => FinancialSummaryModal.fromJson(json.decode(str));

String financialSummaryModalToJson(FinancialSummaryModal data) => json.encode(data.toJson());

class FinancialSummaryModal {
    DateTime? date;
    IncomeStatement? incomeStatement;
    BalanceSheet? balanceSheet;

    FinancialSummaryModal({
        this.date,
        this.incomeStatement,
        this.balanceSheet,
    });

    factory FinancialSummaryModal.fromJson(Map<String, dynamic> json) => FinancialSummaryModal(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        incomeStatement: json["income_statement"] == null ? null : IncomeStatement.fromJson(json["income_statement"]),
        balanceSheet: json["balance_sheet"] == null ? null : BalanceSheet.fromJson(json["balance_sheet"]),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "income_statement": incomeStatement?.toJson(),
        "balance_sheet": balanceSheet?.toJson(),
    };
}

class BalanceSheet {
    Assets? assets;
    Liabilities? liabilities;
    double? equity;

    BalanceSheet({
        this.assets,
        this.liabilities,
        this.equity,
    });

    factory BalanceSheet.fromJson(Map<String, dynamic> json) => BalanceSheet(
        assets: json["assets"] == null ? null : Assets.fromJson(json["assets"]),
        liabilities: json["liabilities"] == null ? null : Liabilities.fromJson(json["liabilities"]),
        equity: json["equity"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "assets": assets?.toJson(),
        "liabilities": liabilities?.toJson(),
        "equity": equity,
    };
}

class Assets {
    double? cashBalance;
    String? loanReceivables;
    double? totalAssets;

    Assets({
        this.cashBalance,
        this.loanReceivables,
        this.totalAssets,
    });

    factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        cashBalance: json["cash_balance"]?.toDouble(),
        loanReceivables: json["loan_receivables"],
        totalAssets: json["total_assets"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "cash_balance": cashBalance,
        "loan_receivables": loanReceivables,
        "total_assets": totalAssets,
    };
}

class Liabilities {
    String? clientDeposits;
    String? totalLiabilities;

    Liabilities({
        this.clientDeposits,
        this.totalLiabilities,
    });

    factory Liabilities.fromJson(Map<String, dynamic> json) => Liabilities(
        clientDeposits: json["client_deposits"],
        totalLiabilities: json["total_liabilities"],
    );

    Map<String, dynamic> toJson() => {
        "client_deposits": clientDeposits,
        "total_liabilities": totalLiabilities,
    };
}

class IncomeStatement {
    int? interestIncome;
    int? feeIncome;
    int? totalRevenue;
    int? operatingExpenses;
    int? netIncome;

    IncomeStatement({
        this.interestIncome,
        this.feeIncome,
        this.totalRevenue,
        this.operatingExpenses,
        this.netIncome,
    });

    factory IncomeStatement.fromJson(Map<String, dynamic> json) => IncomeStatement(
        interestIncome: json["interest_income"],
        feeIncome: json["fee_income"],
        totalRevenue: json["total_revenue"],
        operatingExpenses: json["operating_expenses"],
        netIncome: json["net_income"],
    );

    Map<String, dynamic> toJson() => {
        "interest_income": interestIncome,
        "fee_income": feeIncome,
        "total_revenue": totalRevenue,
        "operating_expenses": operatingExpenses,
        "net_income": netIncome,
    };
}
