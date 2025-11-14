import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);
          final padding = MediaQuery.of(context).padding;

          return SafeArea(
            child: Column(
              children: [
                _Header(scale: scale),
                _FilterBar(scale: scale),
                Expanded(
                  child: Obx(
                    () {
                      final items = controller.filteredNotifications.toList();
                      return CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, (120 * scale) + padding.bottom),
                            sliver: SliverList.separated(
                              itemBuilder: (context, index) => _NotificationCard(
                                scale: scale,
                                item: items[index],
                                onPrimary: () => controller.openNotification(items[index]),
                                onSecondary: () => controller.archive(items[index]),
                                onAccept: items[index].type == NotificationType.friendRequest
                                    ? () => controller.acceptFriendRequest(items[index])
                                    : null,
                                onDecline: items[index].type == NotificationType.friendRequest
                                    ? () => controller.refuseFriendRequest(items[index])
                                    : null,
                                onMarkRead: () => controller.markAsRead(items[index]),
                                timeLabel: controller.formatRelativeTime(items[index]),
                              ),
                              separatorBuilder: (_, __) => SizedBox(height: 12 * scale),
                              itemCount: items.length,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);
          final padding = MediaQuery.of(context).padding;

          return Container(
            padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 16 * scale + padding.bottom),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _SoftButton(
                    scale: scale,
                    icon: Icons.check_circle_outline_rounded,
                    labelTop: 'Tout marquer',
                    labelBottom: 'comme lu',
                    onTap: controller.markAllAsRead,
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: _SoftButton(
                    scale: scale,
                    filled: true,
                    icon: Icons.settings_outlined,
                    labelTop: 'Paramètres',
                    labelBottom: 'notifications',
                    onTap: () => Get.snackbar('Paramètres', 'Gestion des notifications en préparation.'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends GetView<NotificationsController> {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF475569), size: 16 * scale),
          ).gestureDetector(onTap: Get.back),
          SizedBox(width: 12 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 22 * scale, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4 * scale),
              Obx(
                () => Text(
                  '${controller.unreadCount.value} nouvelle${controller.unreadCount.value > 1 ? 's' : ''} notification${controller.unreadCount.value > 1 ? 's' : ''}',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const Spacer(),
          const _IconBadge(),
        ],
      ),
    );
  }
}

class _FilterBar extends GetView<NotificationsController> {
  const _FilterBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12 * scale),
      child: SizedBox(
        height: 42 * scale,
        child: Obx(
          () => ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            itemBuilder: (context, index) {
              final filter = controller.filters[index];
              final isSelected = controller.selectedFilter.value == filter;
              return GestureDetector(
                onTap: () => controller.selectFilter(filter),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6),
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
                  child: Text(
                    filter,
                    style: GoogleFonts.inter(
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
            itemCount: controller.filters.length,
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.scale,
    required this.item,
    required this.onPrimary,
    required this.onSecondary,
    required this.onMarkRead,
    required this.timeLabel,
    this.onAccept,
    this.onDecline,
  });

  final double scale;
  final NotificationItem item;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;
  final VoidCallback onMarkRead;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final String timeLabel;

  Color get accentColor {
    switch (item.type) {
      case NotificationType.comment:
        return const Color(0xFF176BFF);
      case NotificationType.friendRequest:
        return const Color(0xFF16A34A);
      case NotificationType.bookingConfirmed:
        return const Color(0xFFFFB800);
      case NotificationType.paymentError:
        return const Color(0xFFF97316);
      case NotificationType.reward:
        return const Color(0xFFFFB800);
      case NotificationType.announcement:
        return const Color(0xFF0EA5E9);
      case NotificationType.system:
        return const Color(0xFF0EA5E9);
      case NotificationType.friendAccepted:
        return const Color(0xFF176BFF);
      case NotificationType.newMessage:
        return const Color(0xFF176BFF);
    }
  }

  IconData get icon {
    switch (item.type) {
      case NotificationType.comment:
        return Icons.chat_bubble_outline_rounded;
      case NotificationType.friendRequest:
        return Icons.person_add_alt_1_rounded;
      case NotificationType.bookingConfirmed:
        return Icons.event_available_rounded;
      case NotificationType.system:
        return Icons.info_outline_rounded;
      case NotificationType.friendAccepted:
        return Icons.handshake_rounded;
      case NotificationType.newMessage:
        return Icons.mark_chat_unread_rounded;
      case NotificationType.paymentError:
        return Icons.warning_amber_rounded;
      case NotificationType.reward:
        return Icons.emoji_events_rounded;
      case NotificationType.announcement:
        return Icons.campaign_rounded;
    }
  }

  String primaryActionLabel() {
    switch (item.type) {
      case NotificationType.comment:
        return 'Répondre';
      case NotificationType.friendRequest:
        return 'Accepter';
      case NotificationType.bookingConfirmed:
        return 'Voir la réservation';
      case NotificationType.system:
        return 'Détails';
      case NotificationType.friendAccepted:
        return 'Message';
      case NotificationType.newMessage:
        return 'Ouvrir la conversation';
      case NotificationType.paymentError:
        return 'Mettre à jour';
      case NotificationType.reward:
        return 'Voir récompenses';
      case NotificationType.announcement:
        return 'Découvrir';
    }
  }

  String? secondaryActionLabel() {
    switch (item.type) {
      case NotificationType.comment:
        return 'Voir l’annonce';
      case NotificationType.friendRequest:
        return 'Refuser';
      case NotificationType.bookingConfirmed:
        return 'Ajouter au calendrier';
      case NotificationType.system:
        return 'Marquer comme lu';
      case NotificationType.friendAccepted:
        return 'Voir le profil';
      case NotificationType.newMessage:
        return 'Marquer comme lu';
      case NotificationType.paymentError:
        return 'Voir les détails';
      case NotificationType.reward:
        return 'Partager';
      case NotificationType.announcement:
        return 'Plus tard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      background: _SwipeBackground(scale: scale, alignment: Alignment.centerLeft, color: const Color(0xFF16A34A), icon: Icons.done_all_rounded),
      secondaryBackground:
          _SwipeBackground(scale: scale, alignment: Alignment.centerRight, color: const Color(0xFFEF4444), icon: Icons.archive_rounded),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onMarkRead();
        } else {
          onSecondary();
        }
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderRow(scale: scale, item: item, timeLabel: timeLabel, accentColor: accentColor),
            SizedBox(height: 12 * scale),
            _BodySection(scale: scale, item: item, icon: icon, accentColor: accentColor),
            SizedBox(height: 12 * scale),
            _ActionsRow(
              scale: scale,
              item: item,
              primaryLabel: primaryActionLabel(),
              secondaryLabel: secondaryActionLabel(),
              onPrimary: item.type == NotificationType.friendRequest && onAccept != null ? onAccept! : onPrimary,
              onSecondary: item.type == NotificationType.friendRequest && onDecline != null
                  ? onDecline!
                  : () {
                      if (item.type == NotificationType.newMessage || item.type == NotificationType.system) {
                        onMarkRead();
                      } else {
                        onSecondary();
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.scale, required this.item, required this.timeLabel, required this.accentColor});

  final double scale;
  final NotificationItem item;
  final String timeLabel;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Avatar(scale: scale, item: item, accentColor: accentColor),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.fromName,
                      style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(width: 8 * scale),
                  Text(timeLabel, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(height: 4 * scale),
              Text(
                _title(item),
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(width: 12 * scale),
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
            decoration: BoxDecoration(
              color: item.isRead.value ? const Color(0xFFF1F5F9) : accentColor,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              item.isRead.value ? 'Lu' : 'Nouveau',
              style: GoogleFonts.inter(
                color: item.isRead.value ? const Color(0xFF475569) : Colors.white,
                fontSize: 11.5 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _title(NotificationItem item) {
    switch (item.type) {
      case NotificationType.comment:
        return 'A commenté votre annonce « ${item.referenceTitle} »';
      case NotificationType.friendRequest:
        return 'Vous a envoyé une demande d’ami';
      case NotificationType.bookingConfirmed:
        return 'Réservation confirmée';
      case NotificationType.system:
        return 'Notification système';
      case NotificationType.friendAccepted:
        return 'Vous a ajouté dans ses amis';
      case NotificationType.newMessage:
        return 'Nouveau message';
      case NotificationType.paymentError:
        return 'Échec de paiement';
      case NotificationType.reward:
        return 'Niveau ${item.title} atteint !';
      case NotificationType.announcement:
        return item.title ?? 'Annonce Sportify';
    }
  }
}

class _BodySection extends StatelessWidget {
  const _BodySection({required this.scale, required this.item, required this.icon, required this.accentColor});

  final double scale;
  final NotificationItem item;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(14 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36 * scale,
                height: 36 * scale,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: accentColor, size: 20 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(child: _ContentSwitch(scale: scale, item: item, accentColor: accentColor)),
            ],
          ),
          if (item.type == NotificationType.friendRequest && item.mutualSports != null) ...[
            SizedBox(height: 12 * scale),
            Wrap(
              spacing: 8 * scale,
              runSpacing: 8 * scale,
              children: item.mutualSports!
                  .map(
                    (sport) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        sport,
                        style: GoogleFonts.inter(color: const Color(0xFF2563EB), fontSize: 12 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _ContentSwitch extends StatelessWidget {
  const _ContentSwitch({required this.scale, required this.item, required this.accentColor});

  final double scale;
  final NotificationItem item;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      case NotificationType.comment:
        return _TextPreview(scale: scale, message: item.messagePreview ?? '');
      case NotificationType.friendRequest:
        return _TextPreview(scale: scale, message: item.messagePreview ?? '');
      case NotificationType.bookingConfirmed:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(scale: scale, icon: Icons.sports_soccer_rounded, label: item.venue ?? ''),
            SizedBox(height: 6 * scale),
            _InfoRow(scale: scale, icon: Icons.calendar_month_rounded, label: item.schedule ?? ''),
            SizedBox(height: 6 * scale),
            _InfoRow(scale: scale, icon: Icons.payments_rounded, label: item.priceLabel ?? ''),
          ],
        );
      case NotificationType.system:
      case NotificationType.paymentError:
      case NotificationType.reward:
      case NotificationType.announcement:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: item.body
                  ?.map(
                    (line) => Padding(
                      padding: EdgeInsets.only(bottom: 4 * scale),
                      child: Text(
                        line,
                        style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale, height: 1.45),
                      ),
                    ),
                  )
                  .toList() ??
              [],
        );
      case NotificationType.friendAccepted:
        return Text(
          '${item.fromName} est maintenant votre ami. Envoyez-lui un message pour organiser une session !',
          style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale, height: 1.45),
        );
      case NotificationType.newMessage:
        return _TextPreview(scale: scale, message: item.messagePreview ?? '', highlight: accentColor);
    }
  }
}

class _TextPreview extends StatelessWidget {
  const _TextPreview({required this.scale, required this.message, this.highlight});

  final double scale;
  final String message;
  final Color? highlight;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: GoogleFonts.inter(
        color: highlight ?? const Color(0xFF0B1220),
        fontSize: 13.5 * scale,
        height: 1.45,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF475569), size: 16 * scale),
        SizedBox(width: 8 * scale),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({
    required this.scale,
    required this.item,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimary,
    required this.onSecondary,
  });

  final double scale;
  final NotificationItem item;
  final String primaryLabel;
  final String? secondaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    final isCritical = item.type == NotificationType.paymentError;
    final isFriendRequest = item.type == NotificationType.friendRequest;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPrimary,
            style: ElevatedButton.styleFrom(
              backgroundColor: isCritical ? const Color(0xFFF97316) : const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(vertical: 12 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
            ),
            child: Text(
              primaryLabel,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        if (secondaryLabel != null) ...[
          SizedBox(width: 12 * scale),
          Expanded(
            child: OutlinedButton(
              onPressed: onSecondary,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                side: BorderSide(color: isFriendRequest ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0), width: 1 * scale),
              ),
              child: Text(
                secondaryLabel!,
                style: GoogleFonts.inter(color: isFriendRequest ? const Color(0xFFEF4444) : const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.scale, required this.item, required this.accentColor});

  final double scale;
  final NotificationItem item;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    if (item.avatarUrl != null) {
      return CircleAvatar(radius: 24 * scale, backgroundImage: NetworkImage(item.avatarUrl!));
    }
    return Container(
      width: 48 * scale,
      height: 48 * scale,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [accentColor, accentColor.withValues(alpha: 0.7)]),
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.notifications_active_rounded, color: Colors.white, size: 22 * scale),
    );
  }
}

class _SoftButton extends StatelessWidget {
  const _SoftButton({required this.scale, required this.icon, required this.labelTop, required this.labelBottom, required this.onTap, this.filled = false});

  final double scale;
  final IconData icon;
  final String labelTop;
  final String labelBottom;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final background = filled ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6);
    final foreground = filled ? Colors.white : const Color(0xFF475569);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12 * scale),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: filled ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
          boxShadow: filled ? [BoxShadow(color: const Color(0xFF176BFF).withValues(alpha: 0.2), blurRadius: 12 * scale, offset: Offset(0, 8 * scale))] : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: foreground, size: 20 * scale),
            SizedBox(height: 4 * scale),
            Text(labelTop, style: GoogleFonts.inter(color: foreground, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
            Text(labelBottom, style: GoogleFonts.inter(color: foreground, fontSize: 12 * scale)),
          ],
        ),
      ),
    );
  }
}

class _IconBadge extends GetView<NotificationsController> {
  const _IconBadge();

  @override
  Widget build(BuildContext context) {
    const baseSize = 42.0;
    final scale = (MediaQuery.of(context).size.width / 375).clamp(0.9, 1.1);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: baseSize * scale,
          height: baseSize * scale,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(16 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.notifications_active_rounded, color: const Color(0xFF475569), size: 18 * scale),
        ),
        Positioned(
          right: -4 * scale,
          top: -4 * scale,
          child: Obx(
            () {
              final unread = controller.unreadCount.value;
              if (unread == 0) {
                return const SizedBox.shrink();
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 6 * scale, vertical: 2 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white, width: 2 * scale),
                ),
                child: Text(
                  unread.toString(),
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 11 * scale, fontWeight: FontWeight.w700),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({required this.scale, required this.alignment, required this.color, required this.icon});

  final double scale;
  final Alignment alignment;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20 * scale)),
      alignment: alignment,
      padding: EdgeInsets.symmetric(horizontal: 24 * scale),
      child: Icon(icon, color: color, size: 24 * scale),
    );
  }
}

extension on Widget {
  Widget gestureDetector({required VoidCallback onTap}) => GestureDetector(onTap: onTap, child: this);
}

