import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  const ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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
                Expanded(
                  child: Obx(
                    () {
                      if (controller.isLoading.value && controller.messages.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.messages.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucun message',
                            style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14 * scale),
                          ),
                        );
                      }
                      return ListView.builder(
                        controller: controller.scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 24 * scale),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final message = controller.messages[index];
                          final isFirst = index == 0;
                          final nextSender = index < controller.messages.length - 1 ? controller.messages[index + 1].sender : null;
                          final showTime = isFirst || message.sender != nextSender;
                          return _MessageBubble(
                            scale: scale,
                            message: message,
                            showTime: showTime,
                            onImageTap: controller.openMedia,
                          );
                        },
                      );
                    },
                  ),
                ),
                _InputBar(scale: scale),
                SizedBox(height: padding.bottom > 0 ? padding.bottom : 8 * scale),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends GetView<ChatDetailController> {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          _HeaderButton(
            scale: scale,
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.back,
          ),
          SizedBox(width: 12 * scale),
          GestureDetector(
            onTap: controller.openProfile,
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 22 * scale,
                      backgroundImage: NetworkImage(controller.otherUserAvatar),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12 * scale,
                        height: 12 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white, width: 2 * scale),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12 * scale),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.otherUserName,
                      style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      'En ligne • Dernière connexion 5 min',
                      style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          _HeaderButton(
            scale: scale,
            icon: Icons.call_rounded,
            onTap: () => Get.snackbar('Appel', 'Fonction appel à venir.'),
          ),
          SizedBox(width: 12 * scale),
          _HeaderButton(
            scale: scale,
            icon: Icons.more_vert_rounded,
            onTap: controller.openOptions,
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44 * scale,
        height: 44 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 18 * scale),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.scale,
    required this.message,
    required this.showTime,
    required this.onImageTap,
  });

  final double scale;
  final ChatMessage message;
  final bool showTime;
  final void Function(String url) onImageTap;

  bool get isMe => message.sender == ChatSender.me;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6);
    final textColor = isMe ? Colors.white : const Color(0xFF0B1220);
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;

    Widget content;
    switch (message.type) {
      case ChatMessageType.text:
        content = Text(
          message.text ?? '',
          style: GoogleFonts.inter(color: textColor, fontSize: 15 * scale, height: 1.5),
        );
        break;
      case ChatMessageType.media:
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MediaGrid(scale: scale, images: message.images ?? [], onTap: onImageTap),
            if (message.text?.isNotEmpty ?? false) ...[
              SizedBox(height: 10 * scale),
              Text(message.text!, style: GoogleFonts.inter(color: textColor, fontSize: 15 * scale, height: 1.5)),
            ],
          ],
        );
        break;
      case ChatMessageType.voice:
        content = _VoiceMessageBubble(scale: scale, duration: message.voiceDuration ?? Duration.zero, isMe: isMe);
        break;
    }

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: alignment,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6 * scale),
            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
            constraints: BoxConstraints(maxWidth: 260 * scale),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMe ? 18 * scale : 6 * scale),
                topRight: Radius.circular(isMe ? 6 * scale : 18 * scale),
                bottomLeft: Radius.circular(18 * scale),
                bottomRight: Radius.circular(18 * scale),
              ),
              boxShadow: [
                if (isMe)
                  BoxShadow(
                    color: const Color(0xFF176BFF).withValues(alpha: 0.25),
                    blurRadius: 12 * scale,
                    offset: Offset(0, 6 * scale),
                  ),
              ],
            ),
            child: content,
          ),
        ),
        if (showTime)
          Padding(
            padding: EdgeInsets.only(
              left: isMe ? 0 : 8 * scale,
              right: isMe ? 8 * scale : 0,
              bottom: 4 * scale,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  message.timeLabel,
                  style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11.5 * scale),
                ),
                if (isMe && message.status != null) ...[
                  SizedBox(width: 6 * scale),
                  Icon(
                    message.status == ChatMessageStatus.read
                        ? Icons.done_all_rounded
                        : message.status == ChatMessageStatus.sending
                            ? Icons.access_time_rounded
                            : Icons.check_rounded,
                    size: 14 * scale,
                    color: message.status == ChatMessageStatus.read ? const Color(0xFF60A5FA) : const Color(0xFF94A3B8),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _MediaGrid extends StatelessWidget {
  const _MediaGrid({required this.scale, required this.images, required this.onTap});

  final double scale;
  final List<String> images;
  final void Function(String url) onTap;

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return GestureDetector(
        onTap: () => onTap(images.first),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12 * scale),
          child: Image.network(images.first, fit: BoxFit.cover, height: 160 * scale, width: double.infinity),
        ),
      );
    }

    return SizedBox(
      height: 140 * scale,
      child: Row(
        children: images.take(2).map((url) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: url == images.first ? 6 * scale : 0, left: url != images.first ? 6 * scale : 0),
              child: GestureDetector(
                onTap: () => onTap(url),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12 * scale),
                  child: Image.network(url, fit: BoxFit.cover, height: 140 * scale),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _VoiceMessageBubble extends StatelessWidget {
  const _VoiceMessageBubble({required this.scale, required this.duration, required this.isMe});

  final double scale;
  final Duration duration;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final primary = isMe ? Colors.white : const Color(0xFF0B1220);
    final secondary = isMe ? Colors.white.withValues(alpha: 0.7) : const Color(0xFF475569);
    return Row(
      children: [
        Container(
          width: 32 * scale,
          height: 32 * scale,
          decoration: BoxDecoration(
            color: isMe ? Colors.white.withValues(alpha: 0.18) : const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.play_arrow_rounded, color: primary, size: 18 * scale),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20 * scale,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isMe
                        ? [Colors.white.withValues(alpha: 0.4), Colors.white.withValues(alpha: 0.1)]
                        : [const Color(0xFFD9E8FF), const Color(0xFFBFDBFE)],
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: List.generate(
                    24,
                    (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 1 * scale),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        height: (6 + (index % 6) * 2) * scale,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6 * scale),
              Text(
                _formatDuration(duration),
                style: GoogleFonts.inter(color: secondary, fontSize: 12 * scale, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(width: 12 * scale),
        Icon(Icons.equalizer_rounded, color: primary.withValues(alpha: 0.8), size: 18 * scale),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(1, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class _InputBar extends GetView<ChatDetailController> {
  const _InputBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          _InputIcon(
            scale: scale,
            icon: Icons.photo_outlined,
            onTap: () => Get.snackbar('Photos', 'Sélection des photos à venir.'),
          ),
          SizedBox(width: 10 * scale),
          _InputIcon(
            scale: scale,
            icon: Icons.insert_drive_file_outlined,
            onTap: () => Get.snackbar('Fichiers', 'Envoi de documents à venir.'),
          ),
          SizedBox(width: 10 * scale),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(18 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      minLines: 1,
                      maxLines: 4,
                      style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14.5 * scale),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Tapez votre message…',
                        hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14.5 * scale),
                      ),
                      onSubmitted: (_) => controller.sendMessage(),
                    ),
                  ),
                  SizedBox(width: 8 * scale),
                  _EmojiButton(scale: scale),
                ],
              ),
            ),
          ),
          SizedBox(width: 10 * scale),
          GestureDetector(
            onLongPressStart: (_) => controller.toggleRecording(),
            onLongPressEnd: (_) => controller.toggleRecording(),
            onTap: controller.sendMessage,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44 * scale,
              height: 44 * scale,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
                borderRadius: BorderRadius.circular(16 * scale),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF176BFF).withValues(alpha: 0.3), blurRadius: 16 * scale, offset: Offset(0, 8 * scale)),
                ],
              ),
              alignment: Alignment.center,
              child: Obx(
                () => Icon(
                  controller.messageController.text.isNotEmpty ? Icons.send_rounded : Icons.mic_rounded,
                  color: Colors.white,
                  size: 20 * scale,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputIcon extends StatelessWidget {
  const _InputIcon({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 18 * scale),
      ),
    );
  }
}

class _EmojiButton extends StatelessWidget {
  const _EmojiButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Emoji', 'Sélecteur d’emoji à venir.'),
      child: Icon(Icons.emoji_emotions_outlined, color: const Color(0xFF64748B), size: 20 * scale),
    );
  }
}

