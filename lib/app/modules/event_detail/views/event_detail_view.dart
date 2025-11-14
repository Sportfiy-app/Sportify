import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/event_detail_controller.dart';
import '../models/event_detail_model.dart';

class EventDetailView extends GetView<EventDetailController> {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 375.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        bottom: false,
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF176BFF)),
                  strokeWidth: 3,
                ),
              );
            }

            if (controller.event.value == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24 * scale),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80 * scale,
                        height: 80 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline_rounded,
                          size: 40 * scale,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      SizedBox(height: 20 * scale),
                      Text(
                        'Événement introuvable',
                        style: GoogleFonts.poppins(
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B1220),
                        ),
                      ),
                      SizedBox(height: 8 * scale),
                      Text(
                        controller.errorMessage.value ?? 'Impossible de charger l\'événement',
                        style: GoogleFonts.inter(
                          fontSize: 15 * scale,
                          color: const Color(0xFF64748B),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32 * scale),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF176BFF),
                          padding: EdgeInsets.symmetric(horizontal: 32 * scale, vertical: 14 * scale),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Retour',
                          style: GoogleFonts.inter(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return _EventDetailContent(scale: scale, event: controller.event.value!);
          },
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          if (controller.event.value == null) return const SizedBox.shrink();
          final evt = controller.event.value!;
          final isJoining = controller.isJoining.value;

          if (evt.isUserJoined || evt.isUserInWaitingList) {
            return const SizedBox.shrink();
          }

          return SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsets.fromLTRB(20 * scale, 16 * scale, 20 * scale, 20 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20 * scale,
                    offset: Offset(0, -4 * scale),
                  ),
                ],
              ),
              child: evt.isFull
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isJoining
                            ? null
                            : () => controller.joinWaitingList(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB800),
                          padding: EdgeInsets.symmetric(vertical: 16 * scale),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16 * scale),
                          ),
                          elevation: 0,
                        ),
                        child: isJoining
                            ? SizedBox(
                                height: 22 * scale,
                                width: 22 * scale,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time_rounded, size: 20 * scale),
                                  SizedBox(width: 10 * scale),
                                  Text(
                                    'Rejoindre la liste d\'attente',
                                    style: GoogleFonts.inter(
                                      fontSize: 16 * scale,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isJoining
                            ? null
                            : () {
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24 * scale)),
                                    child: Container(
                                      padding: EdgeInsets.all(24 * scale),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Rejoindre l\'événement',
                                            style: GoogleFonts.poppins(
                                              fontSize: 22 * scale,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0B1220),
                                            ),
                                          ),
                                          SizedBox(height: 16 * scale),
                                          Text(
                                            'Voulez-vous rejoindre cet événement ?',
                                            style: GoogleFonts.inter(
                                              fontSize: 15 * scale,
                                              color: const Color(0xFF64748B),
                                              height: 1.5,
                                            ),
                                          ),
                                          SizedBox(height: 20 * scale),
                                          _ConfirmationInfoRow(
                                            scale: scale,
                                            icon: Icons.people_rounded,
                                            label: 'Participants',
                                            value: '${evt.currentParticipants + 1}/${evt.maxParticipants}',
                                          ),
                                          SizedBox(height: 12 * scale),
                                          _ConfirmationInfoRow(
                                            scale: scale,
                                            icon: Icons.calendar_today_rounded,
                                            label: 'Date',
                                            value: _formatDateForBottomDialog(evt.date),
                                          ),
                                          SizedBox(height: 12 * scale),
                                          _ConfirmationInfoRow(
                                            scale: scale,
                                            icon: Icons.location_on_outlined,
                                            label: 'Lieu',
                                            value: evt.location,
                                          ),
                                          SizedBox(height: 24 * scale),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () => Get.back(),
                                                  style: OutlinedButton.styleFrom(
                                                    foregroundColor: const Color(0xFF64748B),
                                                    side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                                                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(14 * scale),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Annuler',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 15 * scale,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 12 * scale),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    controller.joinEvent();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: const Color(0xFF176BFF),
                                                    padding: EdgeInsets.symmetric(vertical: 14 * scale),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(14 * scale),
                                                    ),
                                                    elevation: 0,
                                                  ),
                                                  child: Text(
                                                    'Confirmer',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 15 * scale,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF176BFF),
                          padding: EdgeInsets.symmetric(vertical: 16 * scale),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16 * scale),
                          ),
                          elevation: 0,
                        ),
                        child: isJoining
                            ? SizedBox(
                                height: 22 * scale,
                                width: 22 * scale,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add_rounded, size: 20 * scale),
                                  SizedBox(width: 10 * scale),
                                  Text(
                                    'Rejoindre l\'événement',
                                    style: GoogleFonts.inter(
                                      fontSize: 16 * scale,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  String _formatDateForBottomDialog(DateTime date) {
    final months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class _ConfirmationInfoRow extends StatelessWidget {
  const _ConfirmationInfoRow({
    required this.scale,
    required this.icon,
    required this.label,
    required this.value,
  });

  final double scale;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36 * scale,
          height: 36 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10 * scale),
          ),
          child: Icon(icon, size: 18 * scale, color: const Color(0xFF64748B)),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13 * scale,
                  color: const Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 2 * scale),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1220),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EventDetailContent extends StatelessWidget {
  const _EventDetailContent({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          expandedHeight: 240 * scale,
          floating: false,
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(8 * scale),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8 * scale,
                  offset: Offset(0, 2 * scale),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: const Color(0xFF0B1220), size: 22 * scale),
              onPressed: () => Get.back(),
              padding: EdgeInsets.zero,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF176BFF),
                    const Color(0xFF0F5AE0),
                  ],
                ),
              ),
              child: event.imageUrl != null
                  ? Image.network(
                      event.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _DefaultEventImage(scale: scale),
                    )
                  : _DefaultEventImage(scale: scale),
            ),
          ),
        ),
        // Content
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Info
              _EventHeader(scale: scale, event: event),
              SizedBox(height: 20 * scale),
              // Organizer
              _OrganizerSection(scale: scale, event: event),
              SizedBox(height: 20 * scale),
              // Details
              _EventDetails(scale: scale, event: event),
              SizedBox(height: 20 * scale),
              // Participants
              _ParticipantsSection(scale: scale, event: event),
              SizedBox(height: 20 * scale),
              // Waiting List
              if (event.waitingList.isNotEmpty) ...[
                _WaitingListSection(scale: scale, event: event),
                SizedBox(height: 20 * scale),
              ],
              // Description
              _DescriptionSection(scale: scale, event: event),
              SizedBox(height: 20 * scale),
              // Tags
              if (event.tags.isNotEmpty) ...[
                _TagsSection(scale: scale, event: event),
                SizedBox(height: 20 * scale),
              ],
              SizedBox(height: 100 * scale), // Space for bottom button
            ],
          ),
        ),
      ],
    );
  }
}

class _DefaultEventImage extends StatelessWidget {
  const _DefaultEventImage({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF176BFF),
      child: Center(
        child: Icon(
          Icons.event_rounded,
          size: 72 * scale,
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
    );
  }
}

class _EventHeader extends StatelessWidget {
  const _EventHeader({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventDetailController>();
    
    return Padding(
      padding: EdgeInsets.fromLTRB(20 * scale, 20 * scale, 20 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sport badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFF176BFF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10 * scale),
            ),
            child: Text(
              event.sport,
              style: GoogleFonts.inter(
                fontSize: 13 * scale,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF176BFF),
                letterSpacing: -0.2,
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          // Title
          Text(
            event.title,
            style: GoogleFonts.poppins(
              fontSize: 26 * scale,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1220),
              height: 1.3,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 18 * scale),
          // Date & Time
          Row(
            children: [
              _InfoChip(
                scale: scale,
                icon: Icons.calendar_today_rounded,
                label: _formatDate(event.date),
                color: const Color(0xFF176BFF),
              ),
              SizedBox(width: 10 * scale),
              _InfoChip(
                scale: scale,
                icon: Icons.access_time_rounded,
                label: _formatTime(event.time),
                color: const Color(0xFF16A34A),
              ),
            ],
          ),
          SizedBox(height: 14 * scale),
          // Location
          Row(
            children: [
              Container(
                width: 36 * scale,
                height: 36 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10 * scale),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 18 * scale,
                  color: const Color(0xFF64748B),
                ),
              ),
              SizedBox(width: 10 * scale),
              Expanded(
                child: Text(
                  event.location,
                  style: GoogleFonts.inter(
                    fontSize: 15 * scale,
                    color: const Color(0xFF0B1220),
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24 * scale),
          // Participation Status & Button
          Obx(
            () {
              final evt = controller.event.value!;
              return _ParticipationButton(scale: scale, event: evt);
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun',
      'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return '${days[date.weekday - 1]}. ${date.day} ${months[date.month - 1]}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.scale,
    required this.icon,
    required this.label,
    required this.color,
  });

  final double scale;
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 10 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17 * scale, color: color),
          SizedBox(width: 8 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ParticipationButton extends StatelessWidget {
  const _ParticipationButton({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  String _formatDateInDialog(DateTime date) {
    final months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventDetailController>();

    return Obx(
      () {
        final evt = controller.event.value!;
        final isJoining = controller.isJoining.value;
        final isLeaving = controller.isLeaving.value;

        if (evt.isUserJoined) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(18 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(
                    color: const Color(0xFF16A34A),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44 * scale,
                      height: 44 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFF16A34A).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 24 * scale,
                        color: const Color(0xFF16A34A),
                      ),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vous participez à cet événement',
                            style: GoogleFonts.inter(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF16A34A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            '${evt.currentParticipants}/${evt.maxParticipants} participants',
                            style: GoogleFonts.inter(
                              fontSize: 13 * scale,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14 * scale),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isLeaving
                      ? null
                      : () => _showLeaveConfirmation(context, controller, scale),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFEF4444),
                    side: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 15 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scale),
                    ),
                  ),
                  child: isLeaving
                      ? SizedBox(
                          height: 22 * scale,
                          width: 22 * scale,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFFEF4444)),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.exit_to_app_rounded, size: 20 * scale),
                            SizedBox(width: 10 * scale),
                            Text(
                              'Quitter l\'événement',
                              style: GoogleFonts.inter(
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          );
        }

        if (evt.isUserInWaitingList) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(18 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB800).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(
                    color: const Color(0xFFFFB800),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44 * scale,
                      height: 44 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB800).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Icon(
                        Icons.access_time_rounded,
                        size: 24 * scale,
                        color: const Color(0xFFFFB800),
                      ),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vous êtes en liste d\'attente',
                            style: GoogleFonts.inter(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFFB800),
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            'Position: #${evt.waitingList.indexWhere((p) => p.id == evt.userParticipationId) + 1}',
                            style: GoogleFonts.inter(
                              fontSize: 13 * scale,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14 * scale),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isLeaving
                      ? null
                      : () {
                          Get.dialog(
                            Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24 * scale)),
                              child: Container(
                                padding: EdgeInsets.all(24 * scale),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Quitter la liste d\'attente',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22 * scale,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0B1220),
                                      ),
                                    ),
                                    SizedBox(height: 16 * scale),
                                    Text(
                                      'Êtes-vous sûr de vouloir quitter la liste d\'attente ?',
                                      style: GoogleFonts.inter(
                                        fontSize: 15 * scale,
                                        color: const Color(0xFF64748B),
                                        height: 1.5,
                                      ),
                                    ),
                                    SizedBox(height: 24 * scale),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () => Get.back(),
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: const Color(0xFF64748B),
                                              side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                                              padding: EdgeInsets.symmetric(vertical: 14 * scale),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(14 * scale),
                                              ),
                                            ),
                                            child: Text(
                                              'Annuler',
                                              style: GoogleFonts.inter(
                                                fontSize: 15 * scale,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12 * scale),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              controller.leaveEvent();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFFEF4444),
                                              padding: EdgeInsets.symmetric(vertical: 14 * scale),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(14 * scale),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: Text(
                                              'Quitter',
                                              style: GoogleFonts.inter(
                                                fontSize: 15 * scale,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 15 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scale),
                    ),
                  ),
                  child: isLeaving
                      ? SizedBox(
                          height: 22 * scale,
                          width: 22 * scale,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF64748B)),
                          ),
                        )
                      : Text(
                          'Quitter la liste d\'attente',
                          style: GoogleFonts.inter(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                ),
              ),
            ],
          );
        }

        if (evt.isFull) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(18 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(
                    color: const Color(0xFFEF4444),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44 * scale,
                      height: 44 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Icon(
                        Icons.person_remove_rounded,
                        size: 24 * scale,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Événement complet',
                            style: GoogleFonts.inter(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFEF4444),
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            '${evt.currentParticipants}/${evt.maxParticipants} participants',
                            style: GoogleFonts.inter(
                              fontSize: 13 * scale,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14 * scale),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isJoining
                      ? null
                      : () => controller.joinWaitingList(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB800),
                    padding: EdgeInsets.symmetric(vertical: 15 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scale),
                    ),
                    elevation: 0,
                  ),
                  child: isJoining
                      ? SizedBox(
                          height: 22 * scale,
                          width: 22 * scale,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time_rounded, size: 20 * scale),
                            SizedBox(width: 10 * scale),
                            Text(
                              'Rejoindre la liste d\'attente',
                              style: GoogleFonts.inter(
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          );
        }

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isJoining
                ? null
                : () {
                    final evt = controller.event.value!;
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24 * scale)),
                        child: Container(
                          padding: EdgeInsets.all(24 * scale),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rejoindre l\'événement',
                                style: GoogleFonts.poppins(
                                  fontSize: 22 * scale,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0B1220),
                                ),
                              ),
                              SizedBox(height: 16 * scale),
                              Text(
                                'Voulez-vous rejoindre cet événement ?',
                                style: GoogleFonts.inter(
                                  fontSize: 15 * scale,
                                  color: const Color(0xFF64748B),
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 20 * scale),
                              _ConfirmationInfoRow(
                                scale: scale,
                                icon: Icons.people_rounded,
                                label: 'Participants',
                                value: '${evt.currentParticipants + 1}/${evt.maxParticipants}',
                              ),
                              SizedBox(height: 12 * scale),
                              _ConfirmationInfoRow(
                                scale: scale,
                                icon: Icons.calendar_today_rounded,
                                label: 'Date',
                                value: _formatDateInDialog(evt.date),
                              ),
                              SizedBox(height: 12 * scale),
                              _ConfirmationInfoRow(
                                scale: scale,
                                icon: Icons.location_on_outlined,
                                label: 'Lieu',
                                value: evt.location,
                              ),
                              SizedBox(height: 24 * scale),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => Get.back(),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: const Color(0xFF64748B),
                                        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14 * scale),
                                        ),
                                      ),
                                      child: Text(
                                        'Annuler',
                                        style: GoogleFonts.inter(
                                          fontSize: 15 * scale,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12 * scale),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                        controller.joinEvent();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF176BFF),
                                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14 * scale),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        'Confirmer',
                                        style: GoogleFonts.inter(
                                          fontSize: 15 * scale,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16 * scale),
              ),
              elevation: 0,
            ),
            child: isJoining
                ? SizedBox(
                    height: 22 * scale,
                    width: 22 * scale,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add_rounded, size: 20 * scale),
                      SizedBox(width: 10 * scale),
                      Text(
                        'Rejoindre l\'événement',
                        style: GoogleFonts.inter(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _showLeaveConfirmation(BuildContext context, EventDetailController controller, double scale) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24 * scale)),
        child: Container(
          padding: EdgeInsets.all(24 * scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quitter l\'événement',
                style: GoogleFonts.poppins(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1220),
                ),
              ),
              SizedBox(height: 16 * scale),
              Text(
                'Êtes-vous sûr de vouloir quitter cet événement ? Votre place sera libérée et le premier de la liste d\'attente pourra la prendre.',
                style: GoogleFonts.inter(
                  fontSize: 15 * scale,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24 * scale),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF64748B),
                        side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                      ),
                      child: Text(
                        'Annuler',
                        style: GoogleFonts.inter(
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.leaveEvent();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Quitter',
                        style: GoogleFonts.inter(
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _OrganizerSection extends StatelessWidget {
  const _OrganizerSection({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Container(
        padding: EdgeInsets.all(18 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12 * scale,
              offset: Offset(0, 4 * scale),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32 * scale,
              backgroundImage: NetworkImage(event.organizerAvatar),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organisé par',
                    style: GoogleFonts.inter(
                      fontSize: 12 * scale,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    event.organizerName,
                    style: GoogleFonts.inter(
                      fontSize: 17 * scale,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1220),
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: IconButton(
                onPressed: () {
                  // Navigate to organizer profile
                },
                icon: Icon(Icons.chevron_right_rounded, size: 22 * scale, color: const Color(0xFF94A3B8)),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventDetails extends StatelessWidget {
  const _EventDetails({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Détails',
            style: GoogleFonts.poppins(
              fontSize: 22 * scale,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1220),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12 * scale,
                  offset: Offset(0, 4 * scale),
                ),
              ],
            ),
            child: Column(
              children: [
                _DetailRow(
                  scale: scale,
                  icon: Icons.people_rounded,
                  label: 'Participants',
                  value: '${event.currentParticipants}/${event.maxParticipants}',
                  color: const Color(0xFF176BFF),
                ),
                if (event.difficultyLevel != null) ...[
                  Divider(height: 24 * scale, thickness: 1, color: const Color(0xFFE2E8F0)),
                  _DetailRow(
                    scale: scale,
                    icon: Icons.trending_up_rounded,
                    label: 'Niveau',
                    value: event.difficultyLevel!,
                    color: const Color(0xFFFFB800),
                  ),
                ],
                if (event.price != null) ...[
                  Divider(height: 24 * scale, thickness: 1, color: const Color(0xFFE2E8F0)),
                  _DetailRow(
                    scale: scale,
                    icon: Icons.euro_rounded,
                    label: 'Prix',
                    value: event.price!,
                    color: const Color(0xFF16A34A),
                  ),
                ],
                Divider(height: 24 * scale, thickness: 1, color: const Color(0xFFE2E8F0)),
                _DetailRow(
                  scale: scale,
                  icon: event.isPublic ? Icons.public_rounded : Icons.lock_rounded,
                  label: 'Visibilité',
                  value: event.isPublic ? 'Public' : 'Privé',
                  color: event.isPublic ? const Color(0xFF16A34A) : const Color(0xFF64748B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.scale,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final double scale;
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44 * scale,
          height: 44 * scale,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          child: Icon(icon, size: 22 * scale, color: color),
        ),
        SizedBox(width: 14 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13 * scale,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 3 * scale),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1220),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ParticipantsSection extends StatelessWidget {
  const _ParticipantsSection({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Participants',
                style: GoogleFonts.poppins(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1220),
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 7 * scale),
                decoration: BoxDecoration(
                  color: event.isFull
                      ? const Color(0xFFEF4444).withValues(alpha: 0.1)
                      : const Color(0xFF16A34A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10 * scale),
                  border: Border.all(
                    color: event.isFull
                        ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                        : const Color(0xFF16A34A).withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  '${event.currentParticipants}/${event.maxParticipants}',
                  style: GoogleFonts.inter(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                    color: event.isFull
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF16A34A),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12 * scale,
                  offset: Offset(0, 4 * scale),
                ),
              ],
            ),
            child: event.participants.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(32 * scale),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people_outline_rounded,
                            size: 48 * scale,
                            color: const Color(0xFFCBD5E1),
                          ),
                          SizedBox(height: 12 * scale),
                          Text(
                            'Aucun participant pour le moment',
                            style: GoogleFonts.inter(
                              fontSize: 15 * scale,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Wrap(
                    spacing: 14 * scale,
                    runSpacing: 14 * scale,
                    children: event.participants.map((participant) {
                      return _ParticipantAvatar(
                        scale: scale,
                        participant: participant,
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ParticipantAvatar extends StatelessWidget {
  const _ParticipantAvatar({required this.scale, required this.participant});

  final double scale;
  final EventParticipant participant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 30 * scale,
              backgroundImage: NetworkImage(participant.userAvatar),
            ),
            if (participant.isOrganizer)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 20 * scale,
                  height: 20 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB800),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4 * scale,
                        offset: Offset(0, 2 * scale),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.star_rounded,
                    size: 11 * scale,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8 * scale),
        SizedBox(
          width: 64 * scale,
          child: Text(
            participant.userName,
            style: GoogleFonts.inter(
              fontSize: 12 * scale,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0B1220),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _WaitingListSection extends StatelessWidget {
  const _WaitingListSection({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40 * scale,
                height: 40 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB800).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Icon(
                  Icons.access_time_rounded,
                  size: 22 * scale,
                  color: const Color(0xFFFFB800),
                ),
              ),
              SizedBox(width: 12 * scale),
              Text(
                'Liste d\'attente',
                style: GoogleFonts.poppins(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1220),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(width: 10 * scale),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB800).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Text(
                  '${event.waitingList.length}',
                  style: GoogleFonts.inter(
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFB800),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB800).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(
                color: const Color(0xFFFFB800).withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              children: event.waitingList.asMap().entries.map((entry) {
                final index = entry.key;
                final participant = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: index < event.waitingList.length - 1 ? 16 * scale : 0),
                  child: Row(
                    children: [
                      Container(
                        width: 36 * scale,
                        height: 36 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB800).withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.inter(
                              fontSize: 15 * scale,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFFB800),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14 * scale),
                      CircleAvatar(
                        radius: 22 * scale,
                        backgroundImage: NetworkImage(participant.userAvatar),
                      ),
                      SizedBox(width: 14 * scale),
                      Expanded(
                        child: Text(
                          participant.userName,
                          style: GoogleFonts.inter(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0B1220),
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: GoogleFonts.poppins(
              fontSize: 22 * scale,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1220),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12 * scale,
                  offset: Offset(0, 4 * scale),
                ),
              ],
            ),
            child: Text(
              event.description,
              style: GoogleFonts.inter(
                fontSize: 15 * scale,
                color: const Color(0xFF0B1220),
                height: 1.6,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TagsSection extends StatelessWidget {
  const _TagsSection({required this.scale, required this.event});

  final double scale;
  final EventDetailModel event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tags',
            style: GoogleFonts.poppins(
              fontSize: 22 * scale,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1220),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 10 * scale,
            runSpacing: 10 * scale,
            children: event.tags.map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 10 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10 * scale),
                  border: Border.all(
                    color: const Color(0xFF16A34A).withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.inter(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF16A34A),
                    letterSpacing: -0.2,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
