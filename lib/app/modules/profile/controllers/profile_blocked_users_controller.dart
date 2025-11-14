import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'profile_edit_controller.dart';

class ProfileBlockedUsersController extends GetxController {
  final RxList<BlockedUser> blockedUsers = <BlockedUser>[
    BlockedUser(
      id: '1',
      name: 'Alexandre Martin',
      username: '@alex_martin_75',
      avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
      blockedAgoLabel: 'Bloqué il y a 2 jours',
    ),
    BlockedUser(
      id: '2',
      name: 'Sophie Dubois',
      username: '@sophie_tennis',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      blockedAgoLabel: 'Bloqué il y a 1 semaine',
    ),
    BlockedUser(
      id: '3',
      name: 'Thomas Legrand',
      username: '@thomas_fit',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
      blockedAgoLabel: 'Bloqué il y a 3 semaines',
    ),
  ].obs;

  final RxList<BlockHistoryEntry> history = <BlockHistoryEntry>[
    BlockHistoryEntry(user: 'Marc Durand', relativeTime: 'Il y a 1 mois', statusLabel: 'Débloqué'),
    BlockHistoryEntry(user: 'Julie Martin', relativeTime: 'Il y a 2 mois', statusLabel: 'Débloqué'),
  ].obs;

  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  List<BlockedUser> get filteredBlockedUsers {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return blockedUsers;
    }
    return blockedUsers.where((user) {
      return user.name.toLowerCase().contains(query) || user.username.toLowerCase().contains(query);
    }).toList();
  }

  void toggleSearch(String value) {
    isSearching.value = value.trim().isNotEmpty;
    searchQuery.value = value;
  }

  void confirmUnblock(BlockedUser user) {
    Get.bottomSheet<void>(
      _UnblockSheet(
        user: user,
        onUnblock: () => _unblockUser(user, showToast: true),
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    );
  }

  void _unblockUser(BlockedUser user, {bool showToast = false}) {
    blockedUsers.removeWhere((element) => element.id == user.id);
    history.insert(
      0,
      BlockHistoryEntry(user: user.name, relativeTime: 'À l’instant', statusLabel: 'Débloqué'),
    );
    _markEditSectionUpdated();
    if (showToast) {
      Get.closeCurrentSnackbar();
      Get.back<void>();
      Get.snackbar('Utilisateur débloqué', '${user.name} a été retiré de votre liste de blocage.');
    }
  }

  void unblockAll() {
    if (blockedUsers.isEmpty) return;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Tout débloquer ?'),
        content: const Text(
          'Cette action retirera toutes les personnes de votre liste de blocage. Vous pourrez les rebloquer à tout moment.',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Annuler')),
          FilledButton(
            onPressed: () {
              final snapshot = blockedUsers.toList();
              for (final user in snapshot) {
                _unblockUser(user);
              }
              Get.back();
              Get.snackbar('Liste vidée', 'Tous les utilisateurs ont été débloqués.');
            },
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF176BFF)),
            child: const Text('Tout débloquer'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _markEditSectionUpdated() {
    Get.find<ProfileEditController>().markSectionUpdated('profile_blocked');
  }
}

class _UnblockSheet extends StatelessWidget {
  const _UnblockSheet({required this.user, required this.onUnblock});

  final BlockedUser user;
  final VoidCallback onUnblock;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Text(
                'Que souhaitez-vous faire ?',
                style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onUnblock,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Débloquer l’utilisateur',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: Get.back,
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  foregroundColor: const Color(0xFF475569),
                  backgroundColor: const Color(0xFFF8FAFC),
                ),
                child: Text(
                  'Annuler',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlockedUser {
  BlockedUser({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.blockedAgoLabel,
  });

  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final String blockedAgoLabel;
}

class BlockHistoryEntry {
  BlockHistoryEntry({
    required this.user,
    required this.relativeTime,
    required this.statusLabel,
  });

  final String user;
  final String relativeTime;
  final String statusLabel;
}

