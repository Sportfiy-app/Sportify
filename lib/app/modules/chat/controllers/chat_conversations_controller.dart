import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../../../data/api/api_exception.dart';
import '../../../data/messages/messages_repository.dart';
import '../../../data/messages/models/message_model.dart';
import '../../../data/users/users_repository.dart';
import '../../../routes/app_routes.dart';

class ChatConversationsController extends GetxController {
  ChatConversationsController(this._messagesRepository, this._usersRepository);

  final MessagesRepository _messagesRepository;
  final UsersRepository _usersRepository;

  final searchController = TextEditingController();
  final RxString query = ''.obs;
  final RxList<ConversationItem> conversations = <ConversationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString? errorMessage = RxString(null);
  final RxString currentUserId = ''.obs;

  final RxString selectedFilter = 'Tous'.obs;

  List<String> get filters => const ['Tous', 'Non lus', 'Favoris', 'Groupes'];

  Iterable<ConversationItem> get filteredConversations {
    final list = conversations
        .where((c) => c.name.toLowerCase().contains(query.value.toLowerCase()) || c.lastMessage.toLowerCase().contains(query.value.toLowerCase()));
    switch (selectedFilter.value) {
      case 'Non lus':
        return list.where((c) => c.unreadCount > 0);
      case 'Favoris':
        return list.where((c) => c.pinned);
      case 'Groupes':
        return list.where((c) => c.name.toLowerCase().contains('groupe') || c.name.toLowerCase().contains('club'));
      default:
        return list;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUserId();
    loadConversations();
  }

  Future<void> _loadCurrentUserId() async {
    try {
      final user = await _usersRepository.getCurrentUser();
      currentUserId.value = user.id;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading current user: $e');
      }
    }
  }

  Future<void> loadConversations() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final response = await _messagesRepository.getConversations();
      final conversationsList = (response['conversations'] as List<dynamic>)
          .map((item) => ConversationModel.fromJson(item as Map<String, dynamic>))
          .toList();

      conversations.value = conversationsList.map((conv) => _convertConversationToItem(conv)).toList();
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      if (kDebugMode) {
        debugPrint('Error loading conversations: ${e.message}');
      }
      // Don't show snackbar if it's just "no conversations" - that's normal
      if (e.statusCode != 404) {
        Get.snackbar('Erreur', 'Impossible de charger les conversations: ${e.message}');
      }
    } catch (e) {
      errorMessage.value = 'Une erreur inattendue est survenue';
      if (kDebugMode) {
        debugPrint('Error loading conversations: $e');
      }
      Get.snackbar('Erreur', 'Impossible de charger les conversations');
    } finally {
      isLoading.value = false;
    }
  }

  ConversationItem _convertConversationToItem(ConversationModel conv) {
    final isMe = currentUserId.value.isNotEmpty && conv.lastMessage.senderId == currentUserId.value;
    final lastStatus = isMe
        ? (conv.lastMessage.read ? MessageStatus.read : MessageStatus.sent)
        : null;

    return ConversationItem(
      id: conv.userId,
      name: conv.user.fullName,
      avatarUrl: conv.user.avatarUrl ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=60',
      lastMessage: conv.lastMessage.content,
      lastTimestamp: conv.lastMessage.createdAt,
      unreadCount: conv.unreadCount,
      lastStatus: lastStatus,
      isOnline: false, // TODO: Implement online status
      isTyping: false, // TODO: Implement typing indicator
      isVerified: false, // TODO: Implement verified status
      pinned: false, // TODO: Implement pinned conversations
    );
  }

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void clearSearch() {
    searchController.clear();
    query.value = '';
  }

  void openConversation(ConversationItem conversation) {
    Get.toNamed(Routes.chatDetail, arguments: {
      'userId': conversation.id,
      'userName': conversation.name,
      'userAvatar': conversation.avatarUrl,
    });
  }

  void deleteConversation(ConversationItem conversation) {
    conversations.removeWhere((c) => c.id == conversation.id);
    Get.snackbar('Conversation supprimée', '${conversation.name} a été retiré de vos discussions.');
  }

  void archiveConversation(ConversationItem conversation) {
    Get.snackbar('Conversation archivée', 'Retrouvez ${conversation.name} dans vos archives.');
  }

  void newMessage() {
    Get.snackbar('Nouveau message', 'Sélecteur de contact en préparation.');
  }

  void openSettings() {
    Get.snackbar('Paramètres', 'Gestion du tchat à venir.');
  }

  void openFilters() {
    Get.bottomSheet(
      _FilterSheet(
        controller: this,
        scale: Get.width / 375,
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class _FilterSheet extends StatelessWidget {
  const _FilterSheet({required this.controller, required this.scale});

  final ChatConversationsController controller;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20 * scale, 16 * scale, 20 * scale, 28 * scale + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24 * scale)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 42 * scale,
              height: 4 * scale,
              margin: EdgeInsets.only(bottom: 18 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Text(
            'Filtrer les conversations',
            style: TextStyle(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          ...controller.filters.map(
            (filter) => Obx(
              () => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  filter == 'Non lus'
                      ? Icons.mark_chat_unread_rounded
                      : filter == 'Favoris'
                          ? Icons.push_pin_rounded
                          : filter == 'Groupes'
                              ? Icons.groups_rounded
                              : Icons.chat_bubble_outline_rounded,
                  color: controller.selectedFilter.value == filter ? const Color(0xFF176BFF) : const Color(0xFF94A3B8),
                ),
                title: Text(
                  filter,
                  style: TextStyle(
                    color: controller.selectedFilter.value == filter ? const Color(0xFF176BFF) : const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: controller.selectedFilter.value == filter ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                trailing: controller.selectedFilter.value == filter
                    ? Icon(Icons.check_rounded, color: const Color(0xFF176BFF), size: 20 * scale)
                    : null,
                onTap: () {
                  controller.selectFilter(filter);
                  Get.back();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationItem {
  const ConversationItem({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastTimestamp,
    this.unreadCount = 0,
    this.lastStatus,
    this.isMuted = false,
    this.isOnline = false,
    this.isTyping = false,
    this.isVerified = false,
    this.pinned = false,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final DateTime lastTimestamp;
  final int unreadCount;
  final MessageStatus? lastStatus;
  final bool isMuted;
  final bool isOnline;
  final bool isTyping;
  final bool isVerified;
  final bool pinned;

  ConversationItem copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    String? lastMessage,
    DateTime? lastTimestamp,
    int? unreadCount,
    MessageStatus? lastStatus,
    bool? isMuted,
    bool? isOnline,
    bool? isTyping,
    bool? isVerified,
    bool? pinned,
  }) {
    return ConversationItem(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      unreadCount: unreadCount ?? this.unreadCount,
      lastStatus: lastStatus ?? this.lastStatus,
      isMuted: isMuted ?? this.isMuted,
      isOnline: isOnline ?? this.isOnline,
      isTyping: isTyping ?? this.isTyping,
      isVerified: isVerified ?? this.isVerified,
      pinned: pinned ?? this.pinned,
    );
  }
}

enum MessageStatus { sending, sent, read }
