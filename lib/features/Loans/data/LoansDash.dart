// // To parse this JSON data, do
// //
// //     final loansDash = loansDashFromJson(jsonString);

// import 'dart:convert';

// LoansDash loansDashFromJson(String str) => LoansDash.fromJson(json.decode(str));

// String loansDashToJson(LoansDash data) => json.encode(data.toJson());

// class LoansDash {
//     String? status;
//     Data? data;

//     LoansDash({
//         this.status,
//         this.data,
//     });

//     factory LoansDash.fromJson(Map<String, dynamic> json) => LoansDash(
//         status: json["status"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data?.toJson(),
//     };
// }

// class Data {
//     int? totalClients;
//     int? totalActiveLoans;
//     int? totalPendingLoans;
//     int? totalRunningLoans;
//     String? totalAmountInLoans;

//     Data({
//         this.totalClients,
//         this.totalActiveLoans,
//         this.totalPendingLoans,
//         this.totalRunningLoans,
//         this.totalAmountInLoans,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         totalClients: json["total_clients"],
//         totalActiveLoans: json["total_active_loans"],
//         totalPendingLoans: json["total_pending_loans"],
//         totalRunningLoans: json["total_running_loans"],
//         totalAmountInLoans: json["total_amount_in_loans"],
//     );

//     Map<String, dynamic> toJson() => {
//         "total_clients": totalClients,
//         "total_active_loans": totalActiveLoans,
//         "total_pending_loans": totalPendingLoans,
//         "total_running_loans": totalRunningLoans,
//         "total_amount_in_loans": totalAmountInLoans,
//     };
// }


// lib/models/dashboard_stats.dart

class DashboardStats {
  final int totalClients;
  final int totalActiveLoans;
  final int totalPendingLoans;
  final int totalRunningLoans;
  final String totalAmountInLoans;

  DashboardStats({
    required this.totalClients,
    required this.totalActiveLoans,
    required this.totalPendingLoans,
    required this.totalRunningLoans,
    required this.totalAmountInLoans,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalClients: json['total_clients'] ?? 0,
      totalActiveLoans: json['total_active_loans'] ?? 0,
      totalPendingLoans: json['total_pending_loans'] ?? 0,
      totalRunningLoans: json['total_running_loans'] ?? 0,
      totalAmountInLoans: json['total_amount_in_loans'] ?? '0',
    );
  }
}
