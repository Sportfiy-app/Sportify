class SubscriptionModel {
  const SubscriptionModel({
    required this.id,
    required this.userId,
    required this.plan,
    required this.status,
    this.stripeId,
    required this.currentPeriodStart,
    required this.currentPeriodEnd,
    required this.cancelAtPeriodEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String plan;
  final String status;
  final String? stripeId;
  final String currentPeriodStart;
  final String currentPeriodEnd;
  final bool cancelAtPeriodEnd;
  final String createdAt;
  final String updatedAt;

  bool get isActive => status == 'active' && !cancelAtPeriodEnd;
  bool get isMonthly => plan == 'monthly';
  bool get isAnnual => plan == 'annual';

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      plan: json['plan'] as String,
      status: json['status'] as String,
      stripeId: json['stripeId'] as String?,
      currentPeriodStart: json['currentPeriodStart'] as String,
      currentPeriodEnd: json['currentPeriodEnd'] as String,
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'plan': plan,
      'status': status,
      'stripeId': stripeId,
      'currentPeriodStart': currentPeriodStart,
      'currentPeriodEnd': currentPeriodEnd,
      'cancelAtPeriodEnd': cancelAtPeriodEnd,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

