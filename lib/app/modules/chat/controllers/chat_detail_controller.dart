import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../../../data/api/api_exception.dart';
import '../../../data/messages/messages_repository.dart';
import '../../../data/messages/models/message_model.dart';
import '../../../data/users/users_repository.dart';

class ChatDetailController extends GetxController {
  ChatDetailController(this._messagesRepository, this._usersRepository);

  final MessagesRepository _messagesRepository;
  final UsersRepository _usersRepository;

  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final RxString? errorMessage = RxString(null);
  final RxString? currentUserId = RxString(null);
  final Rx<MessageUser?> otherUser = Rx<MessageUser?>(null);

  String? _otherUserId;
  String? _otherUserName;
  String? _otherUserAvatar;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      _otherUserId = args['userId'] as String?;
      _otherUserName = args['userName'] as String?;
      _otherUserAvatar = args['userAvatar'] as String?;
    } else if (args is String) {
      _otherUserId = args;
    }

    if (_otherUserId == null) {
      Get.back();
      Get.snackbar('Erreur', 'Utilisateur non spécifié');
      return;
    }

    _loadCurrentUserId();
    loadMessages();
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

  Future<void> loadMessages() async {
    if (_otherUserId == null) return;

    isLoading.value = true;
    errorMessage.value = null;
    try {
      final response = await _messagesRepository.getMessages(userId: _otherUserId);
      final messagesList = response.messages;

      messages.value = messagesList.map((msg) => _convertMessageToChatMessage(msg)).toList();
      _scrollToBottom();
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      if (kDebugMode) {
        debugPrint('Error loading messages: ${e.message}');
      }
      Get.snackbar('Erreur', 'Impossible de charger les messages: ${e.message}');
    } catch (e) {
      errorMessage.value = 'Une erreur inattendue est survenue';
      if (kDebugMode) {
        debugPrint('Error loading messages: $e');
      }
      Get.snackbar('Erreur', 'Impossible de charger les messages');
    } finally {
      isLoading.value = false;
    }
  }

  ChatMessage _convertMessageToChatMessage(MessageModel msg) {
    final isMe = msg.senderId == currentUserId.value;
    final sender = isMe ? ChatSender.me : ChatSender.them;

    // Determine message type (for now, only text is supported)
    final type = ChatMessageType.text;

    // Determine status
    ChatMessageStatus? status;
    if (isMe) {
      status = msg.read ? ChatMessageStatus.read : ChatMessageStatus.sent;
    }

    // Format time
    final timeLabel = _formatTime(msg.createdAt);

    return ChatMessage(
      id: msg.id,
      sender: sender,
      type: type,
      text: msg.content,
      timeLabel: timeLabel,
      status: status,
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference < const Duration(minutes: 1)) {
      return 'À l\'instant';
    } else if (difference < const Duration(hours: 1)) {
      return '${difference.inMinutes} min';
    } else if (difference < const Duration(hours: 24)) {
      final hours = dateTime.hour.toString().padLeft(2, '0');
      final minutes = dateTime.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    } else if (difference < const Duration(days: 2)) {
      final hours = dateTime.hour.toString().padLeft(2, '0');
      final minutes = dateTime.minute.toString().padLeft(2, '0');
      return 'Hier $hours:$minutes';
    } else if (difference < const Duration(days: 7)) {
      final weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
      final hours = dateTime.hour.toString().padLeft(2, '0');
      final minutes = dateTime.minute.toString().padLeft(2, '0');
      return '${weekdays[dateTime.weekday - 1]} $hours:$minutes';
    } else {
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final hours = dateTime.hour.toString().padLeft(2, '0');
      final minutes = dateTime.minute.toString().padLeft(2, '0');
      return '$day/$month $hours:$minutes';
    }
  }

  Future<void> sendMessage() async {
    if (_otherUserId == null) return;

    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // Create optimistic message
    final optimisticMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: ChatSender.me,
      type: ChatMessageType.text,
      text: text,
      timeLabel: 'À l\'instant',
      status: ChatMessageStatus.sending,
    );

    messages.add(optimisticMessage);
    messageController.clear();
    _scrollToBottom();

    isSending.value = true;
    try {
      final sentMessage = await _messagesRepository.sendMessage(
        receiverId: _otherUserId!,
        content: text,
      );

      // Replace optimistic message with real one
      final index = messages.indexWhere((m) => m.id == optimisticMessage.id);
      if (index != -1) {
        messages[index] = _convertMessageToChatMessage(sentMessage);
      }

      // Mark messages as read
      await _markMessagesAsRead([sentMessage.id]);
    } on ApiException catch (e) {
      // Remove optimistic message on error
      messages.removeWhere((m) => m.id == optimisticMessage.id);
      Get.snackbar('Erreur', 'Impossible d\'envoyer le message: ${e.message}');
    } catch (e) {
      // Remove optimistic message on error
      messages.removeWhere((m) => m.id == optimisticMessage.id);
      if (kDebugMode) {
        debugPrint('Error sending message: $e');
      }
      Get.snackbar('Erreur', 'Impossible d\'envoyer le message');
    } finally {
      isSending.value = false;
    }
  }

  Future<void> _markMessagesAsRead(List<String> messageIds) async {
    try {
      await _messagesRepository.markAsRead(messageIds);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error marking messages as read: $e');
      }
    }
  }

  void toggleRecording() {
    Get.snackbar('Enregistrement', 'Messages vocaux à venir.');
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }

  void openMedia(String url) {
    Get.snackbar('Galerie', 'Agrandir la photo (${Uri.tryParse(url)?.host ?? 'image'})');
  }

  void openOptions() {
    Get.bottomSheet(
      _OptionsSheet(scale: Get.width / 375),
      backgroundColor: Colors.transparent,
    );
  }

  void openProfile() {
    Get.snackbar('Profil', 'Afficher le profil de votre contact bientôt disponible.');
  }

  String get otherUserName => _otherUserName ?? otherUser.value?.fullName ?? 'Utilisateur';
  String get otherUserAvatar => _otherUserAvatar ?? otherUser.value?.avatarUrl ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=60';

  @override
  void onClose() {
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }
}

class _OptionsSheet extends StatelessWidget {
  const _OptionsSheet({required this.scale});

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
          _OptionRow(
            scale: scale,
            icon: Icons.person_rounded,
            label: 'Voir le profil',
            onTap: () => Get.back(),
          ),
          _OptionRow(
            scale: scale,
            icon: Icons.notifications_off_outlined,
            label: 'Couper les notifications',
            onTap: () => Get.back(),
          ),
          _OptionRow(
            scale: scale,
            icon: Icons.block_rounded,
            label: 'Bloquer',
            color: const Color(0xFFEF4444),
            onTap: () => Get.back(),
          ),
          _OptionRow(
            scale: scale,
            icon: Icons.report_rounded,
            label: 'Signaler',
            color: const Color(0xFFEF4444),
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.scale,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = const Color(0xFF0B1220),
  });

  final double scale;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12 * scale),
        child: Row(
          children: [
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14 * scale),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 20 * scale),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 15 * scale,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ChatSender { me, them }

enum ChatMessageType { text, media, voice }

enum ChatMessageStatus { sending, sent, read }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sender,
    required this.type,
    required this.timeLabel,
    this.text,
    this.images,
    this.voiceDuration,
    this.status,
  });

  final String id;
  final ChatSender sender;
  final ChatMessageType type;
  final String timeLabel;
  final String? text;
  final List<String>? images;
  final Duration? voiceDuration;
  final ChatMessageStatus? status;

  ChatMessage copyWith({
    String? id,
    ChatSender? sender,
    ChatMessageType? type,
    String? timeLabel,
    String? text,
    List<String>? images,
    Duration? voiceDuration,
    ChatMessageStatus? status,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      type: type ?? this.type,
      timeLabel: timeLabel ?? this.timeLabel,
      text: text ?? this.text,
      images: images ?? this.images,
      voiceDuration: voiceDuration ?? this.voiceDuration,
      status: status ?? this.status,
    );
  }
}
