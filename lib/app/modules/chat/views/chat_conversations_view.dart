import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/bottom_navigation/bottom_nav_widget.dart';
import '../controllers/chat_conversations_controller.dart';

class ChatConversationsView extends GetView<ChatConversationsController> {
  const ChatConversationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);

          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                _Header(scale: scale),
                Expanded(
                  child: Obx(
                    () {
                      if (controller.isLoading.value && controller.conversations.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.errorMessage.value != null && controller.conversations.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.errorMessage.value!,
                                style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 14 * scale),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16 * scale),
                              ElevatedButton(
                                onPressed: controller.loadConversations,
                                child: const Text('Réessayer'),
                              ),
                            ],
                          ),
                        );
                      }
                      final items = controller.filteredConversations.toList();
                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucune conversation',
                            style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14 * scale),
                          ),
                        );
                      }
                      return CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 24 * scale),
                            sliver: SliverList.separated(
                              itemCount: items.length,
                              itemBuilder: (context, index) => _ConversationTile(
                                scale: scale,
                                conversation: items[index],
                                onTap: () => controller.openConversation(items[index]),
                                onArchive: () => controller.archiveConversation(items[index]),
                                onDelete: () => controller.deleteConversation(items[index]),
                              ),
                              separatorBuilder: (_, __) => SizedBox(height: 12 * scale),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const BottomNavWidget(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);
          return FloatingActionButton(
            onPressed: controller.newMessage,
            backgroundColor: const Color(0xFF176BFF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18 * scale)),
            child: Icon(Icons.edit_rounded, color: Colors.white, size: 22 * scale),
          );
        },
      ),
    );
  }
}

class _Header extends GetView<ChatConversationsController> {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 20 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Conversations',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 24 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              _CircleButton(
                scale: scale,
                icon: Icons.tune_rounded,
                onTap: controller.openFilters,
              ),
              SizedBox(width: 10 * scale),
              _CircleButton(
                scale: scale,
                icon: Icons.settings_outlined,
                onTap: controller.openSettings,
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          _SearchBar(scale: scale),
          SizedBox(height: 16 * scale),
          _FilterChips(scale: scale),
          SizedBox(height: 4 * scale),
          Obx(
            () => Text(
              '${controller.filteredConversations.length} conversation${controller.filteredConversations.length > 1 ? 's' : ''}',
              style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12.5 * scale, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends GetView<ChatConversationsController> {
  const _SearchBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 18 * scale),
          SizedBox(width: 12 * scale),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Rechercher une conversation…',
                hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14 * scale),
              ),
              style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale),
              onChanged: controller.onSearchChanged,
            ),
          ),
          Obx(
            () => controller.query.value.isNotEmpty
                ? GestureDetector(
                    onTap: controller.clearSearch,
                    child: Icon(Icons.close_rounded, color: const Color(0xFF94A3B8), size: 18 * scale),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends GetView<ChatConversationsController> {
  const _FilterChips({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40 * scale,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.filters.length,
          separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
          itemBuilder: (context, index) {
            final filter = controller.filters[index];
            final isSelected = controller.selectedFilter.value == filter;
            return GestureDetector(
              onTap: () => controller.selectFilter(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF176BFF) : Colors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: isSelected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF176BFF).withValues(alpha: 0.2),
                            blurRadius: 12 * scale,
                            offset: Offset(0, 6 * scale),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Icon(
                      filter == 'Non lus'
                          ? Icons.mark_chat_unread_rounded
                          : filter == 'Favoris'
                              ? Icons.push_pin_rounded
                              : filter == 'Groupes'
                                  ? Icons.groups_rounded
                                  : Icons.chat_bubble_outline_rounded,
                      size: 16 * scale,
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      filter,
                      style: GoogleFonts.inter(
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                        fontSize: 13.5 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42 * scale,
        height: 42 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16 * scale),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 18 * scale),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.scale,
    required this.conversation,
    required this.onTap,
    required this.onArchive,
    required this.onDelete,
  });

  final double scale;
  final ConversationItem conversation;
  final VoidCallback onTap;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(conversation.id),
      background: _DismissBackground(scale: scale, alignment: Alignment.centerLeft, icon: Icons.archive_rounded, color: const Color(0xFF16A34A)),
      secondaryBackground: _DismissBackground(scale: scale, alignment: Alignment.centerRight, icon: Icons.delete_rounded, color: const Color(0xFFEF4444)),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        } else {
          onArchive();
        }
        return false;
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: EdgeInsets.all(16 * scale),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(radius: 24 * scale, backgroundImage: NetworkImage(conversation.avatarUrl)),
                  if (conversation.isOnline)
                    Positioned(
                      right: -1 * scale,
                      bottom: -1 * scale,
                      child: Container(
                        width: 14 * scale,
                        height: 14 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white, width: 2 * scale),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 14 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Text(
                                conversation.name,
                                style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (conversation.isVerified) ...[
                                SizedBox(width: 6 * scale),
                                Icon(Icons.verified_rounded, color: const Color(0xFF60A5FA), size: 16 * scale),
                              ],
                              if (conversation.pinned) ...[
                                SizedBox(width: 6 * scale),
                                Icon(Icons.push_pin_rounded, color: const Color(0xFFF59E0B), size: 16 * scale),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(width: 8 * scale),
                        Text(
                          _formatTimestamp(conversation.lastTimestamp),
                          style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 6 * scale),
                    Row(
                      children: [
                        if (conversation.isTyping)
                          Text(
                            'En train d’écrire…',
                            style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 13 * scale, fontWeight: FontWeight.w500),
                          )
                        else if (conversation.lastStatus != null)
                          Icon(
                            conversation.lastStatus == MessageStatus.read
                                ? Icons.done_all_rounded
                                : conversation.lastStatus == MessageStatus.sending
                                    ? Icons.access_time_rounded
                                    : Icons.check_rounded,
                            size: 16 * scale,
                            color: conversation.lastStatus == MessageStatus.read ? const Color(0xFF60A5FA) : const Color(0xFF94A3B8),
                          ),
                        if (!conversation.isTyping && conversation.lastStatus != null) SizedBox(width: 6 * scale),
                        Expanded(
                          child: Text(
                            conversation.lastMessage,
                            style: GoogleFonts.inter(
                              color: conversation.unreadCount > 0 ? const Color(0xFF0B1220) : const Color(0xFF64748B),
                              fontSize: 13.5 * scale,
                              fontWeight: conversation.unreadCount > 0 ? FontWeight.w600 : FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12 * scale),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (conversation.unreadCount > 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFF176BFF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        conversation.unreadCount.toString(),
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w700),
                      ),
                    )
                  else if (conversation.isMuted)
                    Icon(Icons.notifications_off_rounded, color: const Color(0xFFCBD5F5), size: 18 * scale),
                  if (conversation.isTyping)
                    SizedBox(
                      width: 18 * scale,
                      height: 18 * scale,
                      child: const _TypingDots(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference < const Duration(minutes: 1)) {
      return 'À l’instant';
    } else if (difference < const Duration(hours: 1)) {
      return '${difference.inMinutes} min';
    } else if (difference < const Duration(hours: 24)) {
      return '${difference.inHours} h';
    } else if (difference < const Duration(days: 2)) {
      return 'Hier';
    } else if (difference < const Duration(days: 7)) {
      const weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
      return weekdays[timestamp.weekday - 1];
    } else {
      return '${timestamp.day}/${timestamp.month.toString().padLeft(2, '0')}';
    }
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({required this.scale, required this.alignment, required this.icon, required this.color});

  final double scale;
  final Alignment alignment;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18 * scale),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24 * scale),
      alignment: alignment,
      child: Icon(icon, color: color, size: 22 * scale),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
            (index) {
              final value = (_controller.value + index * 0.2) % 1.0;
              final scale = 0.4 + (value < 0.5 ? value : 1 - value) * 1.2;
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

