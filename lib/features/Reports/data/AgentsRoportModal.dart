// To parse this JSON data, do
//
//     final agentsRoportModal = agentsRoportModalFromJson(jsonString);

import 'dart:convert';

AgentsRoportModal agentsRoportModalFromJson(String str) => AgentsRoportModal.fromJson(json.decode(str));

String agentsRoportModalToJson(AgentsRoportModal data) => json.encode(data.toJson());

class AgentsRoportModal {
    DateTime? date;
    List<Agent>? agents;

    AgentsRoportModal({
        this.date,
        this.agents,
    });

    factory AgentsRoportModal.fromJson(Map<String, dynamic> json) => AgentsRoportModal(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        agents: json["agents"] == null ? [] : List<Agent>.from(json["agents"]!.map((x) => Agent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "agents": agents == null ? [] : List<dynamic>.from(agents!.map((x) => x.toJson())),
    };
}

class Agent {
    int? agentId;
    String? agentName;
    int? loansDisbursed;
    int? numberOfLoansDisbursed;
    int? paymentsCollected;
    int? numberOfPaymentsCollected;

    Agent({
        this.agentId,
        this.agentName,
        this.loansDisbursed,
        this.numberOfLoansDisbursed,
        this.paymentsCollected,
        this.numberOfPaymentsCollected,
    });

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        agentId: json["agent_id"],
        agentName: json["agent_name"],
        loansDisbursed: json["loans_disbursed"],
        numberOfLoansDisbursed: json["number_of_loans_disbursed"],
        paymentsCollected: json["payments_collected"],
        numberOfPaymentsCollected: json["number_of_payments_collected"],
    );

    Map<String, dynamic> toJson() => {
        "agent_id": agentId,
        "agent_name": agentName,
        "loans_disbursed": loansDisbursed,
        "number_of_loans_disbursed": numberOfLoansDisbursed,
        "payments_collected": paymentsCollected,
        "number_of_payments_collected": numberOfPaymentsCollected,
    };
}
