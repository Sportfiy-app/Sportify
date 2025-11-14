class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final bool read;
  final DateTime? readAt;
  final DateTime createdAt;
  final MessageUser? sender;
  final MessageUser? receiver;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.read,
    this.readAt,
    required this.createdAt,
    this.sender,
    this.receiver,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      content: json['content'] as String,
      read: json['read'] as bool? ?? false,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sender: json['sender'] != null
          ? MessageUser.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
      receiver: json['receiver'] != null
          ? MessageUser.fromJson(json['receiver'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MessageUser {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;

  MessageUser({
    required this.id,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    }
    return 'Utilisateur';
  }

  factory MessageUser.fromJson(Map<String, dynamic> json) {
    return MessageUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }
}

class ConversationModel {
  final String userId;
  final MessageUser user;
  final MessageModel lastMessage;
  final int unreadCount;

  ConversationModel({
    required this.userId,
    required this.user,
    required this.lastMessage,
    required this.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      userId: json['userId'] as String,
      user: MessageUser.fromJson(json['user'] as Map<String, dynamic>),
      lastMessage: MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadCount: json['unreadCount'] as int? ?? 0,
    );
  }
}

class MessagesListResponse {
  final List<MessageModel> messages;
  final int total;
  final int limit;
  final int offset;

  MessagesListResponse({
    required this.messages,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory MessagesListResponse.fromJson(Map<String, dynamic> json) {
    return MessagesListResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((item) => MessageModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      limit: json['limit'] as int,
      offset: json['offset'] as int,
    );
  }
}

