// To parse this JSON data, do
//
//     final clientsRoportModal = clientsRoportModalFromJson(jsonString);

import 'dart:convert';

ClientsRoportModal clientsRoportModalFromJson(String str) => ClientsRoportModal.fromJson(json.decode(str));

String clientsRoportModalToJson(ClientsRoportModal data) => json.encode(data.toJson());

class ClientsRoportModal {
    DateTime? date;
    int? newClients;
    int? totalActiveClients;

    ClientsRoportModal({
        this.date,
        this.newClients,
        this.totalActiveClients,
    });

    factory ClientsRoportModal.fromJson(Map<String, dynamic> json) => ClientsRoportModal(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        newClients: json["new_clients"],
        totalActiveClients: json["total_active_clients"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "new_clients": newClients,
        "total_active_clients": totalActiveClients,
    };
}
