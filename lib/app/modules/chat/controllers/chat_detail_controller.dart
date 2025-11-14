import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  final RxList<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      id: 'm1',
      sender: ChatSender.them,
      type: ChatMessageType.text,
      text: 'Salut ! Tu es dispo pour un match de tennis ce soir ? 🎾',
      timeLabel: '14:25',
    ),
    ChatMessage(
      id: 'm2',
      sender: ChatSender.me,
      type: ChatMessageType.text,
      text: 'Oui parfait ! À quelle heure ?',
      timeLabel: '14:26',
      status: ChatMessageStatus.read,
    ),
    ChatMessage(
      id: 'm3',
      sender: ChatSender.them,
      type: ChatMessageType.media,
      images: const [
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=600&q=60',
        'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=600&q=60',
      ],
      text: 'Regarde ce terrain ! On peut réserver pour 19h.',
      timeLabel: '14:28',
    ),
    ChatMessage(
      id: 'm4',
      sender: ChatSender.me,
      type: ChatMessageType.voice,
      voiceDuration: const Duration(seconds: 35),
      timeLabel: '14:30',
      status: ChatMessageStatus.read,
    ),
    ChatMessage(
      id: 'm5',
      sender: ChatSender.them,
      type: ChatMessageType.text,
      text: 'Génial ! J’ai hâte 😄 Tu as ton équipement ?',
      timeLabel: '14:32',
    ),
    ChatMessage(
      id: 'm6',
      sender: ChatSender.me,
      type: ChatMessageType.text,
      text: 'Oui j’ai tout ! On se retrouve directement là-bas ?',
      timeLabel: '14:33',
      status: ChatMessageStatus.read,
    ),
    ChatMessage(
      id: 'm7',
      sender: ChatSender.them,
      type: ChatMessageType.media,
      images: const [
        'https://images.unsplash.com/photo-1527708673438-91226c61d3ef?auto=format&fit=crop&w=1200&q=60',
      ],
      text: 'Voici l’adresse exacte du club.',
      timeLabel: '14:35',
    ),
    ChatMessage(
      id: 'm8',
      sender: ChatSender.me,
      type: ChatMessageType.text,
      text: 'Parfait ! À tout à l’heure 👋',
      timeLabel: '14:36',
      status: ChatMessageStatus.read,
    ),
  ].obs;

  final RxBool isRecording = false.obs;

  void toggleRecording() {
    isRecording.toggle();
    if (isRecording.value) {
      Get.snackbar('Enregistrement', 'Maintenez pour enregistrer un vocal.');
    } else {
      Get.snackbar('Enregistrement', 'Message vocal enregistré.');
    }
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: ChatSender.me,
      type: ChatMessageType.text,
      text: text,
      timeLabel: 'À l’instant',
      status: ChatMessageStatus.sending,
    );
    messages.add(message);
    messageController.clear();
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 800), () {
      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        messages[index] = messages[index].copyWith(
          status: ChatMessageStatus.read,
          timeLabel: 'À l’instant',
        );
      }
    });
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

  @override
  void onInit() {
    super.onInit();
    _scrollToBottom();
  }

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

