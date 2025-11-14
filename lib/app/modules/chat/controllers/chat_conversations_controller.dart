import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ChatConversationsController extends GetxController {
  final searchController = TextEditingController();
  final RxString query = ''.obs;

  final RxList<ConversationItem> conversations = <ConversationItem>[
    ConversationItem(
      id: 'c1',
      name: 'Margot Doe',
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=60',
      lastMessage: 'Parfait ! À tout à l’heure 👋',
      lastTimestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      unreadCount: 2,
      isOnline: true,
    ),
    ConversationItem(
      id: 'c2',
      name: 'Sarah Martin',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      lastMessage: 'Je suis en route !',
      lastTimestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      unreadCount: 0,
      lastStatus: MessageStatus.read,
      isTyping: true,
    ),
    ConversationItem(
      id: 'c3',
      name: 'Equipe Sportify',
      avatarUrl: 'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=200&q=60',
      lastMessage: 'Votre réservation pour ce soir est confirmée ✅',
      lastTimestamp: DateTime.now().subtract(const Duration(hours: 5)),
      unreadCount: 0,
      isVerified: true,
      pinned: true,
    ),
    ConversationItem(
      id: 'c4',
      name: 'Club Padel Paris',
      avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
      lastMessage: 'Nouvelle session disponibles demain à 18h.',
      lastTimestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      unreadCount: 4,
    ),
    ConversationItem(
      id: 'c5',
      name: 'Thomas',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
      lastMessage: 'Super match hier, merci !',
      lastTimestamp: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
      lastStatus: MessageStatus.sent,
    ),
    ConversationItem(
      id: 'c6',
      name: 'Groupe Running Bois',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      lastMessage: 'Encore 3 places pour demain matin 🏃‍♂️',
      lastTimestamp: DateTime.now().subtract(const Duration(days: 3)),
      unreadCount: 0,
      isMuted: true,
    ),
  ].obs;

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
    Get.toNamed(Routes.chatDetail, arguments: conversation.id);
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

