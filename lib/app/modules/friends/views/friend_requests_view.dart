import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/friend_requests_controller.dart';
import '../../../data/friends/models/friend_model.dart';

class FriendRequestsView extends GetView<FriendRequestsController> {
  const FriendRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0B1220)),
          onPressed: Get.back,
        ),
        title: Text(
          'Demandes d\'amis',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0B1220),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _TabBar(controller: controller),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);

          return Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final requests = controller.activeTab.value == 'received'
                  ? controller.receivedRequests
                  : controller.sentRequests;

              if (requests.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1_outlined,
                        size: 64 * scale,
                        color: const Color(0xFF94A3B8),
                      ),
                      SizedBox(height: 16 * scale),
                      Text(
                        controller.activeTab.value == 'received'
                            ? 'Aucune demande reçue'
                            : 'Aucune demande envoyée',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF0B1220),
                          fontSize: 18 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8 * scale),
                      Text(
                        controller.activeTab.value == 'received'
                            ? 'Vous n\'avez pas de nouvelles demandes d\'amis'
                            : 'Vous n\'avez envoyé aucune demande',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF64748B),
                          fontSize: 14 * scale,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(16 * scale),
                itemCount: requests.length,
                separatorBuilder: (_, __) => SizedBox(height: 12 * scale),
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return _RequestCard(
                    scale: scale,
                    request: request,
                    isReceived: controller.activeTab.value == 'received',
                    onAccept: controller.activeTab.value == 'received'
                        ? () => controller.acceptRequest(request)
                        : null,
                    onReject: controller.activeTab.value == 'received'
                        ? () => controller.rejectRequest(request)
                        : () => controller.cancelSentRequest(request),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.controller});

  final FriendRequestsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => _TabButton(
                label: 'Reçues (${controller.receivedRequests.length})',
                isActive: controller.activeTab.value == 'received',
                onTap: () => controller.switchTab('received'),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => _TabButton(
                label: 'Envoyées (${controller.sentRequests.length})',
                isActive: controller.activeTab.value == 'sent',
                onTap: () => controller.switchTab('sent'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF176BFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isActive ? Colors.white : const Color(0xFF64748B),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.scale,
    required this.request,
    required this.isReceived,
    this.onAccept,
    required this.onReject,
  });

  final double scale;
  final FriendRequestModel request;
  final bool isReceived;
  final VoidCallback? onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    // For received requests, show requester; for sent requests, show addressee
    final user = isReceived ? request.requester : request.addressee;

    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12 * scale,
            offset: Offset(0, 6 * scale),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28 * scale,
            backgroundImage: NetworkImage(
              user.avatarUrl ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=60',
            ),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  isReceived
                      ? 'Vous a envoyé une demande d\'ami'
                      : 'Demande en attente',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 13 * scale,
                  ),
                ),
                if (user.city != null) ...[
                  SizedBox(height: 4 * scale),
                  Row(
                    children: [
                      Icon(Icons.place_outlined, size: 12 * scale, color: const Color(0xFF94A3B8)),
                      SizedBox(width: 4 * scale),
                      Text(
                        user.city!,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF94A3B8),
                          fontSize: 12 * scale,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          if (isReceived && onAccept != null)
            Column(
              children: [
                _ActionButton(
                  scale: scale,
                  label: 'Accepter',
                  color: const Color(0xFF16A34A),
                  onTap: onAccept!,
                ),
                SizedBox(height: 8 * scale),
                _ActionButton(
                  scale: scale,
                  label: 'Refuser',
                  color: const Color(0xFFEF4444),
                  onTap: onReject,
                ),
              ],
            )
          else
            _ActionButton(
              scale: scale,
              label: 'Annuler',
              color: const Color(0xFF64748B),
              onTap: onReject,
            ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.scale,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final double scale;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12 * scale),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

