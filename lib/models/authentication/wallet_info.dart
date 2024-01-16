class Wallet {
  final String id;
  final String userId;
  final String amount;
  final bool? isBlocked;
  final String createdAt;
  final String updatedAt;
  final int bonus;

  const Wallet({
    required this.id,
    required this.userId,
    required this.amount,
    this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    required this.bonus,
  });

  // camelCase for json
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'],
      isBlocked: json['isBlocked'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      bonus: json['bonus'],
    );
  }
}
